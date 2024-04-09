import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUniversityWidget extends StatefulWidget {
  @override
  _AddUniversityWidgetState createState() => _AddUniversityWidgetState();
}

class _AddUniversityWidgetState extends State<AddUniversityWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberStudentsController =
      TextEditingController();
  final TextEditingController _usersAppController = TextEditingController();
  final TextEditingController _appPenetrationController =
      TextEditingController();
  String _statusMessage = '';

  Future<void> _addUniversity() async {
    final String name = _nameController.text;
    final int? numberStudents = int.tryParse(_numberStudentsController.text);
    final int? usersApp = int.tryParse(_usersAppController.text);
    final double? appPenetration =
        double.tryParse(_appPenetrationController.text);

    if (name.isEmpty ||
        numberStudents == null ||
        usersApp == null ||
        appPenetration == null) {
      setState(() {
        _statusMessage = 'Please fill in all fields with valid data.';
      });
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('universities').add({
        'name': name,
        'number_students': numberStudents,
        'users_app': usersApp,
        'app_penetration': appPenetration,
      });
      setState(() {
        _statusMessage = 'University added successfully!';
      });
    } on FirebaseException catch (e) {
      setState(() {
        _statusMessage = 'Firebase error: ${e.message}';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Unknown error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          controller: _appPenetrationController,
          decoration: InputDecoration(labelText: 'App Penetration (0.0 - 1.0)'),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
        ),
        ElevatedButton(
          onPressed: _addUniversity,
          child: Text('Add University'),
        ),
        Text(_statusMessage),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberStudentsController.dispose();
    _usersAppController.dispose();
    _appPenetrationController.dispose();
    super.dispose();
  }
}
