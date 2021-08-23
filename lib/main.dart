import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:funda_assignment/resources/resources.dart';
import 'package:funda_assignment/screens/splash/splash_screen.dart';

Future<void> main() async {
  runApp(FundaApp());
}

class FundaApp extends StatefulWidget {
  @override
  _FundaAppState createState() => _FundaAppState();
}

class _FundaAppState extends State<FundaApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('nl', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Resources.APP_PRIMARY_COLOR,
        accentColor: Resources.APP_ACCENT_COLOR,
        splashColor: Resources.APP_PRIMARY_A33,
        canvasColor: Colors.transparent,
      ),
      home: SplashScreen(),
    );
  }

}
