import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'university_logo_uploader.dart'; // Make sure this import points to the correct file

class AddUniversityWidget extends StatefulWidget {
  @override
  _AddUniversityWidgetState createState() => _AddUniversityWidgetState();
}

class _AddUniversityWidgetState extends State<AddUniversityWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberStudentsController =
      TextEditingController();
  final TextEditingController _usersAppController = TextEditingController();
  final TextEditingController _newlyEnrolledController =
      TextEditingController();
  String _statusMessage = '';
  double? _appPenetration;
  String _logoUrl = ''; // New state variable to store the logo URL

  Future<void> _addUniversity() async {
    final String name = _nameController.text;
    final int? numberStudents = int.tryParse(_numberStudentsController.text);
    final int? usersApp = int.tryParse(_usersAppController.text);
    final int? newlyEnrolled =
        int.tryParse(_newlyEnrolledController.text); // Get value for new field

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
      return; // Exit the function if no logo URL is available
    }

    // Calculate app penetration as a whole number
    final double appPenetrationRate = (usersApp / numberStudents) * 100;
    setState(() {
      _appPenetration =
          appPenetrationRate; // Store the whole number, not a decimal
      _statusMessage = 'Calculating...';
    });

    // Reference to Firestore collection
    final collectionRef = FirebaseFirestore.instance.collection('universities');

    try {
      // Check if university already exists
      final querySnapshot =
          await collectionRef.where('name', isEqualTo: name).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        // University exists, so update it
        await collectionRef.doc(querySnapshot.docs.first.id).update({
          'number_students': numberStudents,
          'users_app': usersApp,
          'app_penetration':
              appPenetrationRate, // Store the whole number percentage
          'newly_enrolled': newlyEnrolled,
        });
        _statusMessage = 'University updated successfully!';
      } else {
        // University does not exist, so create it
        await collectionRef.add({
          'name': name,
          'number_students': numberStudents,
          'users_app': usersApp,
          'app_penetration':
              appPenetrationRate, // Store the whole number percentage
          'newly_enrolled': newlyEnrolled,
          'logo': _logoUrl // Include the logo URL in the update
        });
        _statusMessage = 'University added successfully!';
      }
    } on FirebaseException catch (e) {
      _statusMessage = 'Firebase error: ${e.message}';
      _appPenetration = null;
    } catch (e) {
      _statusMessage = 'Unknown error: $e';
      _appPenetration = null;
    }

    // Update the UI
    setState(() {});
  }

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
        UploadLogoButton(
          onUploaded: (String url) {
            setState(() {
              _logoUrl = url;
            });
          },
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _addUniversity,
          child: Text('Add University'),
        ),
        if (_appPenetration != null)
          Text('App Penetration Rate: ${_appPenetration!.toStringAsFixed(2)}%'),
        Text(_statusMessage),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberStudentsController.dispose();
    _usersAppController.dispose();
    _newlyEnrolledController.dispose();
    super.dispose();
  }
}
