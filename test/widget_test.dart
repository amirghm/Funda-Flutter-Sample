import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fund_sample/screens/home/home_screen.dart';
import 'package:fund_sample/screens/splash/splash_screen.dart';

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
