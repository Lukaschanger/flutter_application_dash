import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Add University'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Add Harvard'),
            onPressed: addHarvardUniversity,
          ),
        ),
      ),
    );
  }
}

Future<void> addHarvardUniversity() async {
  CollectionReference universities =
      FirebaseFirestore.instance.collection('universities');

  return universities
      .doc('Harvard')
      .set({
        'university_name': 'Harvard University',
        'number_students':
            25266, // Enrollment number based on the provided data
        // You can add more fields here
      })
      .then((value) => print("Harvard University Added"))
      .catchError((error) => print("Failed to add Harvard University: $error"));
}
