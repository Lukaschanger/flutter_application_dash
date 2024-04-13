import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_dash/AddUniversityWidget.dart';

void main() {
  group('AddUniversityWidget UI Tests', () {
    testWidgets('Displays all text fields and allows input',
        (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddUniversityWidget(),
          ),
        ),
      );

      // Verify that all TextFields are displayed
      expect(find.byType(TextField),
          findsNWidgets(4)); // Assuming there are 4 TextFields

      // Enter text into each TextField
      final nameFinder = find.byType(TextField).at(0);
      final numberStudentsFinder = find.byType(TextField).at(1);
      final usersAppFinder = find.byType(TextField).at(2);
      final newlyEnrolledFinder = find.byType(TextField).at(3);

      // Enter valid data into TextFields
      await tester.enterText(nameFinder, 'University X');
      await tester.enterText(numberStudentsFinder, '1000');
      await tester.enterText(usersAppFinder, '500');
      await tester.enterText(newlyEnrolledFinder, '300');

      // Rebuild the widget with the new state
      await tester.pump();

      // Verify the entered text is displayed in each TextField
      expect(find.text('University X'), findsOneWidget);
      expect(find.text('1000'), findsOneWidget);
      expect(find.text('500'), findsOneWidget);
      expect(find.text('300'), findsOneWidget);
    });
  });
}
