import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UniversityLogoUploader extends StatefulWidget {
  final TextEditingController nameController;

  UniversityLogoUploader({Key? key, required this.nameController})
      : super(key: key);

  @override
  _UniversityLogoUploaderState createState() => _UniversityLogoUploaderState();
}

class _UniversityLogoUploaderState extends State<UniversityLogoUploader> {
  Uint8List? _universityLogo;
  String? _uploadedFileURL;
  String _statusMessage = '';

  Future<void> _pickLogo() async {
    // ... your existing code for picking the logo ...
  }

  Future<void> _uploadLogo() async {
    final String universityName = widget.nameController.text;
    if (_universityLogo == null || universityName.isEmpty) {
      setState(() {
        _statusMessage = 'Please enter a name and pick an image first.';
      });
      return;
    }

    final fileName = 'university_logos/$universityName.png';
    final ref = FirebaseStorage.instance.ref().child(fileName);

    try {
      // ... your existing code for uploading the logo ...
    } catch (e) {
      // ... your existing error handling code ...
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ... your existing code for build method ...
        ElevatedButton(
          onPressed: _uploadLogo, // Update to call _uploadLogo directly
          child: Text('Upload Logo'),
        ),
        // ... your existing code ...
      ],
    );
  }
}
