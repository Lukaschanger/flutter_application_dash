import 'package:flutter/material.dart';
import 'vertical_navbar.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Define a darker orange color
    Color darkOrange = Color(0xFFF57C00);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          VerticalNavbar(), // Ensure this navbar aligns with the design
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/images/Lukas_OrangeBackground.jpg'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Lukas Kromminga',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: darkOrange,
                      ),
                    ),
                    Text(
                      'Co-Founder',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Lottie.asset(
                      'assets/animations/lottie_students.json',
                      width: 200, // Set the width to fit your layout
                      height: 200, // Set the height to fit your layout
                      repeat: true, // Set to true if you want it to loop
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.location_on, color: darkOrange),
                      title: Text('Birkenhof 2, 72070, Dußlingen, Germany'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: darkOrange),
                      title: Text('1-800-225-5532'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: darkOrange),
                      title: Text('lukas@connou.app'),
                      onTap: () =>
                          launchUrl(Uri.parse('mailto:lukas@connou.app')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
