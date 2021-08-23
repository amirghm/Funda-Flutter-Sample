import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funda_assignment/data/repository/local/app_preferences.dart';
import 'package:funda_assignment/resources/resources.dart';
import 'package:funda_assignment/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    initializeAppConfigs();
  }

  initializeAppConfigs() async {
    await AppPreferences.init();
    updateLocale();
  }

  void updateLocale() {
    Locale appLocale = Localizations.localeOf(context);
    AppPreferences.setLocale(appLocale.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness:  Brightness.light,
          systemNavigationBarIconBrightness:  Brightness.dark),
      child: _splashWidget(),
    );
  }

  Widget _splashWidget() {
    return Container(
        color: Resources.APP_PRIMARY_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset('assets/ic_splash_logo.png',width: 120,),
            ),
          ],
        ));
  }

  void startTimer() {
    if (timer == null)
      timer = Timer(Duration(seconds: 3), () async {
        timer?.cancel();
        await AppPreferences.init();
        HomeScreen.open(context);
      });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
}
