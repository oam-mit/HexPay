import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexpay/backend/models/WebViewArguments.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    WebViewArguments arguments = ModalRoute.of(context).settings.arguments;
    return WebView(
      initialUrl: arguments.url,
    );
  }
}
