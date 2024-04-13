import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_dash/github.dart';

void main() {
  group('GithubSignInButton UI Tests', () {
    testWidgets('Displays the button and responds to tap',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GithubSignInButton(),
          ),
        ),
      );

      // Verify the button is displayed
      final Finder githubButton = find.byType(ElevatedButton);
      expect(githubButton, findsOneWidget);
      expect(find.text('Sign in with GitHub'), findsOneWidget);
      expect(find.byIcon(Icons.code), findsOneWidget);

      // Attempt to tap the button
      await tester.tap(githubButton);

      // Trigger a frame
      await tester.pump();

      // Verify that a Snackbar is displayed after tap.
      // Since we're not mocking, we cannot verify the actual sign-in behavior,
      // but we can verify that a tap on the button shows a Snackbar,
      // which means the onPressed callback is triggered.
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
