import 'package:flutter/material.dart';
import 'package:flutter_application_dash/statcard.dart';
import 'package:flutter_application_dash/vertical_navbar.dart';
import 'package:flutter_application_dash/university_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedUniversityId = "wFfHSatiVSqW9LJQzwpr";
  Map<String, dynamic> _universityData = {
    'number_students': '0',
    'app_penetration': '0',
    'users_app': '0',
    'newly_enrolled': '0',
  };

  void _onUniversitySelected(String universityId) {
    setState(() {
      _selectedUniversityId = universityId;
    });
    _fetchUniversityData(universityId);
  }

  void _fetchUniversityData(String universityId) {
    FirebaseFirestore.instance
        .collection('universities')
        .doc(universityId)
        .get()
        .then((documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          _universityData = documentSnapshot.data() as Map<String, dynamic>;
        });
      }
    }).catchError((error) {
      // Handle errors, e.g., show a Snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching university data: $error'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          VerticalNavbar(), // Integrated as part of the main layout
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 1,
                      children: [
                        StatCard(
                          title: 'Number of Students',
                          value: _universityData['number_students'].toString(),
                          change:
                              'Updated', // You could make this dynamic based on data
                          icon: Icons.people,
                          color: Colors.redAccent,
                        ),
                        StatCard(
                          title: 'App Penetration',
                          value: '${_universityData['app_penetration']}%',
                          change: 'Updated',
                          icon: Icons.show_chart,
                          color: Colors.blueAccent,
                        ),
                        StatCard(
                          title: 'App Users',
                          value: _universityData['users_app'].toString(),
                          change: 'Updated',
                          icon: Icons.phone_iphone,
                          color: Colors.amber,
                        ),
                        StatCard(
                          title: 'Newly Enrolled Students',
                          value: _universityData['newly_enrolled'].toString(),
                          change: 'Updated',
                          icon: Icons.school,
                          color: Colors.greenAccent,
                        ),
                      ],
                    ),
                  ),
                  UniversityDropdown(onSelected: _onUniversitySelected),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
