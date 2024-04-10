import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UniversityDropdown extends StatefulWidget {
  final Function(String)? onSelected;

  UniversityDropdown({this.onSelected, Key? key}) : super(key: key);

  @override
  _UniversityDropdownState createState() => _UniversityDropdownState();
}

class _UniversityDropdownState extends State<UniversityDropdown> {
  final Stream<QuerySnapshot> _universitiesStream =
      FirebaseFirestore.instance.collection('universities').snapshots();
  String? selectedUniversity;
  String? logoUrl;

  void _fetchUniversityLogo(String universityId) {
    FirebaseFirestore.instance
        .collection('universities')
        .doc(universityId)
        .get()
        .then((document) {
      setState(() {
        logoUrl = document.data()?['logo'] as String?;
      });
    }).catchError((error) {
      print("Error fetching logo: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _universitiesStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<DropdownMenuItem<String>> universityItems = snapshot
                  .data!.docs
                  .map((DocumentSnapshot document) {
                    var data = document.data()
                        as Map<String, dynamic>?; // Safely cast the data
                    if (data != null && data.containsKey('name')) {
                      return DropdownMenuItem<String>(
                        value: document.id, // Use the document ID as the value
                        child: Text(data['name']),
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
                  if (newValue != null) {
                    _fetchUniversityLogo(newValue);
                    if (widget.onSelected != null) {
                      widget.onSelected!(newValue);
                    }
                  }
                },
                dropdownColor: Colors.white,
              );
            } else {
              return Text('No universities found');
            }
          },
        ),
        if (logoUrl != null)
          Image.network(
            logoUrl!,
            width: 100,
            height: 100,
            errorBuilder: (context, error, stackTrace) {
              print(
                  'Failed to load image: $error'); // Debug: log any image loading errors
              return Icon(Icons
                  .error); // Display an error icon if the image fails to load
            },
          ),
      ],
    );
  }
}
