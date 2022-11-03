import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class NewsDetailPage extends StatelessWidget {
  String? url;
  NewsDetailPage({this.url});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
    );
  }
}
