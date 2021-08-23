// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:funda_assignment/screens/home/home_screen.dart';
import 'package:funda_assignment/screens/splash/splash_screen.dart';

void main() {

  testWidgets('Check Splash Screen Loaded Successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home:SplashScreen()));

    // Verify that our screen loaded successfully.
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Check App Home Screen Widget Load', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home:HomeScreen()));

    // Verify that our screen loaded successfully.
    expect(find.textContaining('Hello'), findsOneWidget);
    expect(find.text('Bye'), findsNothing);

  });
}
