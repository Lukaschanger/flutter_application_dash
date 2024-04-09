import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UniversityDropdown extends StatefulWidget {
  @override
  _UniversityDropdownState createState() => _UniversityDropdownState();
}

class _UniversityDropdownState extends State<UniversityDropdown> {
  final Stream<QuerySnapshot> _universitiesStream =
      FirebaseFirestore.instance.collection('universities').snapshots();
  String? selectedUniversity;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _universitiesStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<DropdownMenuItem<String>> universityItems = snapshot.data!.docs
              .map((DocumentSnapshot document) {
                var data = document.data()
                    as Map<String, dynamic>?; // Safely cast the data
                if (data != null && data.containsKey('university_name')) {
                  return DropdownMenuItem<String>(
                    value: data['university_name'],
                    child: Text(data['university_name']),
                  );
                } else {
                  return null;
                }
              })
              .where((item) => item != null)
              .cast<DropdownMenuItem<String>>()
              .toList();

          return DropdownButton<String>(
            value: selectedUniversity,
            isExpanded: true,
            hint: Text('Select a university'),
            items: universityItems,
            onChanged: (String? newValue) {
              setState(() {
                selectedUniversity = newValue;
              });
            },
            dropdownColor: Colors.white,
          );
        } else {
          return Text('No universities found');
        }
      },
    );
  }
}
