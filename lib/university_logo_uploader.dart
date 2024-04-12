import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadLogoButton extends StatefulWidget {
  final Function(String) onUploaded;

  UploadLogoButton({required this.onUploaded});

  @override
  _UploadLogoButtonState createState() => _UploadLogoButtonState();
}

class _UploadLogoButtonState extends State<UploadLogoButton> {
  final ImagePicker picker = ImagePicker();

  Future<void> uploadLogo() async {
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageBytes = await pickedFile.readAsBytes();
      String fileName =
          'university_logos/${DateTime.now().millisecondsSinceEpoch.toString()}.png';
      try {
        TaskSnapshot taskSnapshot =
            await FirebaseStorage.instance.ref(fileName).putData(imageBytes);
        String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        widget.onUploaded(downloadUrl); // Use the callback to pass the URL back
      } catch (e) {
        print("Error uploading image: $e");
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
