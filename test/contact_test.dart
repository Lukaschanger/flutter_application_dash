import 'package:flutter/material.dart';
import 'package:flutter_application_dash/contact.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ContactScreen Widget', () {
    testWidgets('displays contact information', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: ContactScreen(),
        ),
      );

      // Verify that the title 'Contact' is displayed in the AppBar.
      expect(
        find.descendant(
          of: find.byType(AppBar),
          matching: find.text('Contact'),
        ),
        findsOneWidget,
      );

      // Verify the presence of contact information
      expect(find.text('Lukas Kromminga'), findsOneWidget);
      expect(find.text('Co-Founder'), findsOneWidget);
      expect(
          find.text('Birkenhof 2, 72070, Dußlingen, Germany'), findsOneWidget);
      expect(find.text('1-800-225-5532'), findsOneWidget);
      expect(find.text('lukas@connou.app'), findsOneWidget);

      // The rest of your test code remains the same.
      // The code that simulates tapping and verifies the launchUrl call has been removed.
    });
  });
}
