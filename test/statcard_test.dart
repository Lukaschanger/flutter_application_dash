import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_dash/statcard.dart';

void main() {
  testWidgets('displays the correct texts, icon, and color',
      (WidgetTester tester) async {
    const title = 'Test Title';
    const value = '123';
    const change = '+4.56%';
    const icon = Icons.trending_up;
    const color = Colors.blue;

    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StatCard(
          title: title,
          value: value,
          change: change,
          icon: icon,
          color: color,
        ),
      ),
    ));

    // Verify that our StatCard shows the correct contents.
    expect(find.text(title), findsOneWidget);
    expect(find.text(value), findsOneWidget);
    expect(find.text(change), findsOneWidget);
    expect(find.byIcon(icon), findsOneWidget);

    // Verify the background color of the StatCard is as expected.
    final container = tester.widget<Container>(find.byType(Container));
    expect((container.decoration as BoxDecoration).color, equals(color));
  });
}
