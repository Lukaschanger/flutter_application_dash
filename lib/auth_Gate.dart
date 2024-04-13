import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_dash/github.dart';

import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(
                  clientId:
                      "723281765635-pfnsr5omnaaeacm56ccl7tbkmbn8sqm8.apps.googleusercontent.com"),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.3,
                    child: Image.asset('assets/images/logo.png',
                        errorBuilder: (context, error, stackTrace) {
                      return Text('Failed to load logo',
                          textAlign: TextAlign.center);
                    }),
                  ),
                  Text('Sign In', style: Theme.of(context).textTheme.headline5),
                ],
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to Connou, please sign in!')
                    : const Text('Welcome to Connou, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return Column(
                children: [
                  SizedBox(
                      height:
                          16), // Space between Google button and your custom button
                  GithubSignInButton(), // Your custom GitHub sign-in button
                  SizedBox(
                      height:
                          20), // More space before the terms and conditions text
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text(
                      'By signing in, you agree to our terms and conditions.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return const HomeScreen();
      },
    );
  }
}
