import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_dash/UniversityFormWidget.dart';
import 'package:flutter_application_dash/testwidget.dart';
import 'vertical_navbar.dart';
import 'university_dropdown.dart'; // Make sure to import your new widget

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
                  UniversityDropdown(), // Use your new UniversityDropdown widget
                  Spacer(),
                  UniversityFormWidget(),
                  Spacer(),
                  AddUniversityWidget(), // To push the logout button to the bottom of the screen
                  Spacer(),
                  SignOutButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
