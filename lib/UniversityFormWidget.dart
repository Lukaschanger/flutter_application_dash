import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UniversityFormWidget extends StatefulWidget {
  @override
  _UniversityFormWidgetState createState() => _UniversityFormWidgetState();
}

class _UniversityFormWidgetState extends State<UniversityFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> addUser(String name, String email, int age) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users
        .add({
          'name': name,
          'email': email,
          'age': age,
        })
        .then((value) => print("User added successfully!"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addUniversity(String name) async {
    CollectionReference universities =
        FirebaseFirestore.instance.collection('universities');
    return universities
        .add({
          'university_name': name
        }) // Save the university name under 'university_name' field
        .then((value) => print('University Added'))
        .catchError((error) => print('Failed to add university: $error'));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      addUniversity(_nameController.text.trim());
      _nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'University Name'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a university name';
              }
              return null; // The input is valid
            },
          ),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text('Add University'),
          ),
        ],
      ),
    );
  }
}
