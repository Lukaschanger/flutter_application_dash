import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GithubSignInButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  GithubSignInButton({Key? key}) : super(key: key);

  Future<void> signInWithGithub(BuildContext context) async {
    try {
      // Create a new GitHubAuthProvider instance
      final GithubAuthProvider githubProvider = GithubAuthProvider();
      githubProvider.addScope('read:user');
      githubProvider.addScope('user:email');
      githubProvider.setCustomParameters({
        'allow_signup': 'true',
      });

      // Sign in with the GitHub provider using a popup
      final UserCredential userCredential =
          await _auth.signInWithPopup(githubProvider);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Successfully signed in with GitHub!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to sign in with GitHub: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(Icons.code), // coding icon
      label: Text('Sign in with GitHub'),
      onPressed: () => signInWithGithub(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black, // Background color for the button
        foregroundColor: Colors.white, // Text and icon color
        minimumSize: Size(double.infinity, 50), // Full-width button
      ),
    );
  }
}
