import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_dash/AddUniversityWidget.dart';
import 'vertical_navbar.dart';

class OptionsScreen extends StatefulWidget {
  @override
  _OptionsScreenState createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options'),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          VerticalNavbar(), // Your custom vertical navigation bar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Universities',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 20), // Space between header and dropdown
                  AddUniversityWidget(), // To push the logout button to the bottom of the screen
                  Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[350]),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (Route<dynamic> route) => false);
                    },
                    child: const Text('SignOut'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
