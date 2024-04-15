import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Defines a widget for uploading university logos to Firebase Storage.
class UniversityLogoUploader extends StatefulWidget {
  // Callback function to handle the URL of the uploaded image.
  final Function(String) onLogoUploaded;

  // Constructor that requires the callback function.
  UniversityLogoUploader({required this.onLogoUploaded});

  @override
  _UniversityLogoUploaderState createState() => _UniversityLogoUploaderState();
}

class _UniversityLogoUploaderState extends State<UniversityLogoUploader> {
  // ImagePicker instance for picking images from the gallery.
  final ImagePicker _picker = ImagePicker();

  // Method to handle the process of uploading a logo.
  Future<void> _uploadUniversityLogo() async {
    // Open the image gallery to pick an image.
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    // Check if an image was selected.
    if (pickedFile != null) {
      // Read the image file as a list of bytes.
      Uint8List imageBytes = await pickedFile.readAsBytes();
      // Create a unique file name based on the current timestamp.
      String fileName =
          'university_logos/${DateTime.now().millisecondsSinceEpoch}.png';

      try {
        // Upload the image to Firebase Storage and retrieve the download URL.
        TaskSnapshot taskSnapshot =
            await FirebaseStorage.instance.ref(fileName).putData(imageBytes);
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();

        // Invoke the callback function with the URL of the uploaded image.
        widget.onLogoUploaded(downloadUrl);
      } catch (e) {
        // Log any errors during the upload process.
        print("Error uploading image: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Provides a button to trigger the upload process.
    return ElevatedButton(
      onPressed: _uploadUniversityLogo,
      child: Text('Upload University Logo'),
    );
  }
}
