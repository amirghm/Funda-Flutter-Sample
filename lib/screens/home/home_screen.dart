
import 'package:flutter/material.dart';
import 'package:fund_sample/resources/resources.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  static const HOME_ROUTE = '/Home';

  static void open(BuildContext context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        ModalRoute.withName(HOME_ROUTE));
  }
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBarWidget(),
        body: Center(child: Text('Hello Funda World :)')),
    );
  }

  _appBarWidget() {
    return AppBar(backgroundColor: Resources.APP_PRIMARY_COLOR,
    title: Text(Resources.getString('app__name'),
    style: Resources.getTitleStyle(),),
    brightness: Brightness.dark,);
  }

}