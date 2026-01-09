import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Challenge1Page extends StatefulWidget {
  final Function(WebViewController) onWebViewCreated;

  const Challenge1Page({
    super.key,
    required this.onWebViewCreated,
  });

  @override
  State<Challenge1Page> createState() => _Challenge1PageState();
}

class _Challenge1PageState extends State<Challenge1Page> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadFlutterAsset('assets/index.html');

    widget.onWebViewCreated(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
