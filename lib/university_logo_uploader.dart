import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class UploadLogoButton extends StatefulWidget {
  @override
  _UploadLogoButtonState createState() => _UploadLogoButtonState();
}

class _UploadLogoButtonState extends State<UploadLogoButton> {
  final picker = ImagePicker();

  Future<void> uploadLogo() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List? imageBytes;
      String fileName =
          'university_logos/${DateTime.now().millisecondsSinceEpoch.toString()}.png';

      if (kIsWeb) {
        // On web, we work with bytes
        imageBytes = await pickedFile.readAsBytes();
      }

      try {
        // Upload image to Firebase Storage
        TaskSnapshot taskSnapshot;

        if (kIsWeb && imageBytes != null) {
          // Upload bytes directly if it's a web app
          taskSnapshot =
              await FirebaseStorage.instance.ref(fileName).putData(imageBytes);
        } else {
          // Fallback for non-web platforms
          File imageFile = File(pickedFile.path);
          taskSnapshot =
              await FirebaseStorage.instance.ref(fileName).putFile(imageFile);
        }

        // Get image URL from Firebase Storage
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Add image URL to Firestore collection
        await FirebaseFirestore.instance.collection('universities').add({
          'logo': downloadUrl,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logo uploaded successfully!')),
        );
      } catch (e) {
        // Handle errors
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error uploading logo: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: uploadLogo,
      child: Text('Upload University Logo'),
    );
  }
}
