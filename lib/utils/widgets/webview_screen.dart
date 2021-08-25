import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fund_sample/resources/resources.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({Key? key, required this.title, required this.url})
      : super(key: key);

  static Future<dynamic> open(BuildContext context, String title, String url) {
    return Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => WebViewScreen(title: title, url: url)),
    );
  }

  @override
  _WebViewScreenState createState() => _WebViewScreenState(title, url);
}

class _WebViewScreenState extends State<WebViewScreen> {
  late String title;
  late String url;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final Set<Factory> gestureRecognizers =
      [Factory(() => EagerGestureRecognizer())].toSet();
  UniqueKey _key = UniqueKey();

  _WebViewScreenState(String title, String url) {
    this.title = title;
    this.url = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBarWidget(), body: _bodyWidget());
  }

  _appBarWidget() {
    return AppBar(
        backgroundColor: Resources.APP_PRIMARY_COLOR,
        elevation: 0.4,
        leading: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.keyboard_backspace,
              size: 24,
              color: Colors.white,
            )),
        title: Text(
          title,
          style: Resources.getToolbarTitleStyle(),
        ));
  }

  _bodyWidget() {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onVerticalDragStart: (DragStartDetails details) {},
        child: WebView(
            key: _key,
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
              ),
            ].toSet(),
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            }),
      ),
    );
  }
}
