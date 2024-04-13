import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_dash/auth_gate.dart';
import 'package:flutter_application_dash/github.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthGate UI Tests', () {
    testWidgets('Displays SignInScreen when there is no user',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: AuthGate(),
        ),
      );

      // Verify that the SignInScreen is displayed
      expect(find.byType(SignInScreen), findsOneWidget);

      // Verify that the logo and sign-in/up messages are displayed
      expect(find.text('Sign In'), findsOneWidget);
      expect(find.text('Welcome to Connou, please sign in!'), findsOneWidget);
      expect(find.text('Welcome to Connou, please sign up!'),
          findsNothing); // Assuming sign-in is the default

      // Verify that the custom GitHub sign-in button is displayed
      expect(find.byType(GithubSignInButton), findsOneWidget);

      // Verify the terms and conditions text is displayed
      expect(find.text('By signing in, you agree to our terms and conditions.'),
          findsOneWidget);

      // Check for logo image, replace 'logo.png' with the correct asset if it's different
      expect(find.byType(Image), findsWidgets);
    });
  });
}
