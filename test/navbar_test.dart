import 'package:flutter/material.dart';
import 'package:flutter_application_dash/vertical_navbar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VerticalNavbar Widget', () {
    testWidgets('renders a list of navigation tiles',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VerticalNavbar(),
          ),
        ),
      );

      // Verify that the VerticalNavbar builds its menu with the expected tiles.
      expect(find.byType(ListTile),
          findsNWidgets(3)); // Assuming there are three ListTiles
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Contact'), findsOneWidget);
      expect(find.text('Options'), findsOneWidget);
      // You could also check for Icons if you want.

      // You can also test navigation if you have set up routes in MaterialApp.
      // For example:
      // await tester.tap(find.text('Home'));
      // await tester.pumpAndSettle(); // This simulates the navigation animation.
      // expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
