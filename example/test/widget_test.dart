import 'package:example/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App initializes correctly and navigates to ListViewScreen', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const MyApp());

    // Verify the HomeScreen is displayed
    expect(find.text('Flutter Animation'), findsOneWidget);
    expect(find.text('fadeIn'), findsOneWidget);
    expect(find.text('slideRTL'), findsOneWidget);

    // Tap on the 'fadeIn' list item
    await tester.tap(find.text('fadeIn'));
    await tester.pumpAndSettle();

    // Verify the ListViewScreen is displayed with the correct title
    expect(find.text('fadeIn'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);

    // Verify the ListView contains items
    expect(find.text('Item 0'), findsOneWidget);
    expect(find.text('Item 1'), findsOneWidget);

    // Tap back to go to HomeScreen
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Verify the HomeScreen is displayed again
    expect(find.text('Flutter Animation'), findsOneWidget);

    // Test AnimatedText
    expect(find.text('CountUp'), findsOneWidget);
    expect(find.text('CountDown'), findsOneWidget);
    expect(find.text('Typing'), findsOneWidget);
  });
}
