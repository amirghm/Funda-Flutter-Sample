import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:funda_sample/data/models/media.dart';
import 'package:funda_sample/data/repository/remote/house_repository.dart';
import 'package:funda_sample/resources/resources.dart';
import 'package:funda_sample/screens/gallery/photo_gallery_screen.dart';

import 'package:funda_sample/screens/home/home_screen.dart';
import 'package:funda_sample/screens/home/home_viewmodel.dart';
import 'package:funda_sample/screens/splash/splash_screen.dart';
import 'package:funda_sample/screens/webview/webview_screen.dart';
import 'package:funda_sample/utils/network/network_service.dart';
import 'package:provider/provider.dart';

void main() {

  testWidgets('Check Splash Screen Loaded Successfully', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home:SplashScreen()));
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Check App Home Screen Widget Loaded Successfully', (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: HomeViewModel(houseRepository: HouseRepository(networkService: NetworkService()))),
        ],child: MaterialApp(home:HomeScreen())));
    expect(find.byType(FloatingActionButton),findsOneWidget);
  });

  testWidgets('Check Photo Gallery Screen Loaded Successfully', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home:PhotoGalleryScreen(photos: [Media()],tag: '',index: 0,)));

    expect(find.byIcon(Icons.share), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_backspace), findsOneWidget);
  });

  testWidgets('Check Webview Screen Loaded Successfully', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home:WebViewScreen(title: 'test',url: 'url',)));

    expect(find.text('test'), findsOneWidget);
    expect(find.byIcon(Icons.keyboard_backspace), findsOneWidget);
  });
}
