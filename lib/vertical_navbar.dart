import 'package:flutter/material.dart';

class VerticalNavbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200, // Set the width of the navbar
      // Set no colour
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pushNamed(context, '/home'),
          ),
          ListTile(
            leading: const Icon(Icons.contacts),
            title: const Text('Contact'),
            onTap: () => Navigator.pushNamed(context, '/contact'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Options'),
            onTap: () => Navigator.pushNamed(context, '/options'),
          ),
        ],
      ),
    );
  }
}
