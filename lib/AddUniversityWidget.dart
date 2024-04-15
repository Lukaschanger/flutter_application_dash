import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_dash/university_logo_uploader.dart';

// Stateful widget to handle the UI and logic for adding a university.
class AddUniversityWidget extends StatefulWidget {
  @override
  _AddUniversityWidgetState createState() => _AddUniversityWidgetState();
}

// State class for AddUniversityWidget.
class _AddUniversityWidgetState extends State<AddUniversityWidget> {
  // Text editing controllers to handle form inputs.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberStudentsController =
      TextEditingController();
  final TextEditingController _usersAppController = TextEditingController();
  final TextEditingController _newlyEnrolledController =
      TextEditingController();
  String _statusMessage = ''; // To display status messages to the user.
  int?
      _appPenetration; // Optional integer to store the calculated app penetration rate.
  String _logoUrl = ''; // To store the uploaded logo URL.

  // Function to handle the logic for adding or updating a university entry in Firestore.
  Future<void> _addUniversity() async {
    // Extract text from controllers.
    final String name = _nameController.text;
    final int? numberStudents = int.tryParse(_numberStudentsController.text);
    final int? usersApp = int.tryParse(_usersAppController.text);
    final int? newlyEnrolled = int.tryParse(_newlyEnrolledController.text);

    // Validation checks.
    if (name.isEmpty ||
        numberStudents == null ||
        usersApp == null ||
        newlyEnrolled == null ||
        numberStudents == 0) {
      setState(() {
        _statusMessage = 'Please fill in all fields with valid data.';
      });
      return;
    }

    if (_logoUrl.isEmpty) {
      setState(() {
        _statusMessage = 'Please upload a logo before submitting.';
      });
      return;
    }

    // Calculate app penetration rate and update UI to show the calculation is happening.
    final int appPenetrationRate = ((usersApp / numberStudents) * 100).round();
    setState(() {
      _appPenetration = appPenetrationRate;
      _statusMessage = 'Calculating...';
    });

    // Reference to the Firestore collection.
    final collectionRef = FirebaseFirestore.instance.collection('universities');

    try {
      // Check if a university with the same name already exists.
      final querySnapshot =
          await collectionRef.where('name', isEqualTo: name).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        // If it exists, update the existing university data.
        await collectionRef.doc(querySnapshot.docs.first.id).update({
          'number_students': numberStudents,
          'users_app': usersApp,
          'app_penetration': appPenetrationRate,
          'newly_enrolled': newlyEnrolled,
          'logo': _logoUrl
        });
        _statusMessage = 'University updated successfully!';
      } else {
        // If it does not exist, add a new university entry.
        await collectionRef.add({
          'name': name,
          'number_students': numberStudents,
          'users_app': usersApp,
          'app_penetration': appPenetrationRate,
          'newly_enrolled': newlyEnrolled,
          'logo': _logoUrl
        });
        _statusMessage = 'University added successfully!';
      }
    } catch (e) {
      // Handle errors from Firestore.
      _statusMessage = 'Error: $e';
      _appPenetration = null;
    }

    // Update the UI after operation.
    setState(() {});
  }

  // Building the widget tree for the UI.
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'University Name'),
        ),
        TextField(
          controller: _numberStudentsController,
          decoration: InputDecoration(labelText: 'Number of Students'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _usersAppController,
          decoration: InputDecoration(labelText: 'App Users'),
          keyboardType: TextInputType.number,
        ),
        TextField(
          controller: _newlyEnrolledController,
          decoration: InputDecoration(
              labelText: 'Newly Enrolled Students Last Semester'),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        UniversityLogoUploader(
          onLogoUploaded: (String url) {
            setState(() {
              _logoUrl = url; // Update state with the new logo URL.
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _addUniversity, // Button to trigger university addition.
          child: Text('Add University'),
        ),
        if (_appPenetration != null)
          Text(
              'App Penetration Rate: ${_appPenetration}%'), // Display calculated app penetration rate.
        Text(_statusMessage), // Display the current status message.
      ],
    );
  }

  // Dispose all controllers when the widget is disposed.
  @override
  void dispose() {
    _nameController.dispose();
    _numberStudentsController.dispose();
    _usersAppController.dispose();
    _newlyEnrolledController.dispose();
    super.dispose();
  }
}
