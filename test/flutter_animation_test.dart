import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_animation/src/flutter_animated_text.dart';

void main() {
  testWidgets('FlutterAnimatedText countUp animation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: FlutterAnimatedText(
        startValue: 0,
        endValue: 100,
        animationType: TextAnimationType.countUp,
        duration: Duration(seconds: 1),
      )),
    ));

    await tester.pump(); // Start the animation

    expect(find.text('0'), findsOneWidget); // Initially

    // Check intermediate value
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(Text), findsOneWidget);

    // At the end of the duration, the value should be 100
    await tester.pumpAndSettle();
    expect(find.text('100'), findsOneWidget);
  });

  testWidgets('FlutterAnimatedText countDown animation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: FlutterAnimatedText(
        startValue: 100,
        endValue: 0,
        animationType: TextAnimationType.countDown,
        duration: Duration(seconds: 1),
      )),
    ));

    await tester.pump(); // Start the animation

    expect(find.text('100'), findsOneWidget); // Initially

    // Check intermediate value
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(Text), findsOneWidget);

    // At the end of the duration, the value should be 0
    await tester.pumpAndSettle();
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('FlutterAnimatedText typing animation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: FlutterAnimatedText(
        normalText: 'Hello',
        animationType: TextAnimationType.typing,
        duration: Duration(seconds: 1),
      )),
    ));

    await tester.pump(); // Start the animation

    expect(find.text(''), findsOneWidget); // Initially

    // Check intermediate value
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.textContaining('He'), findsOneWidget);

    // At the end of the duration, the text should be 'Hello'
    await tester.pumpAndSettle();
    expect(find.text('Hello'), findsOneWidget);
  });

  testWidgets('FlutterAnimatedText none animation', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
          body: FlutterAnimatedText(
        normalText: 'Static Text',
        animationType: TextAnimationType.none,
      )),
    ));

    await tester.pumpAndSettle(); // No animation but wait for the widget to render

    expect(find.text('Static Text'), findsOneWidget); // Static text
  });
}
