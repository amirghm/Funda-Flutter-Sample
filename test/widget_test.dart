import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fund_sample/data/models/media.dart';
import 'package:fund_sample/resources/resources.dart';
import 'package:fund_sample/screens/gallery/photo_gallery_screen.dart';

import 'package:fund_sample/screens/home/home_screen.dart';
import 'package:fund_sample/screens/splash/splash_screen.dart';
import 'package:fund_sample/screens/webview/webview_screen.dart';

void main() {

  testWidgets('Check Splash Screen Loaded Successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home:SplashScreen()));

    // Verify that our screen loaded successfully.
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Check App Home Screen Widget Loaded Successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home:HomeScreen()));

    // Verify that our screen loaded successfully.
    expect(find.byType(FloatingActionButton),findsOneWidget);
  });

  testWidgets('Check Photo Gallery Screen Loaded Successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home:PhotoGalleryScreen(images: [Media()],tag: '',index: 0,)));

    // Verify that our screen loaded successfully.
    expect(find.byIcon(Icons.share), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_backspace), findsOneWidget);

  });

  testWidgets('Check Webview Screen Loaded Successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home:WebViewScreen(title: 'test',url: 'url',)));

    // Verify that our screen loaded successfully.
    expect(find.text('test'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_backspace), findsOneWidget);

  });
}
