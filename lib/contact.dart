import 'package:flutter/material.dart';
import 'vertical_navbar.dart'; // Make sure to import the VerticalNavbar widget

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact'),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          VerticalNavbar(), // Your custom vertical navigation bar
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    child: const Text(
                        'LK'), // Placeholder text or you can put an image here
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Lukas Kromminga',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Co-Founder',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '1-800-225-5532',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
