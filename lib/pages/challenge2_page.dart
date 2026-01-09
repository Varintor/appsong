import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Challenge2Page extends StatefulWidget {
  final Function(WebViewController) onWebViewCreated;

  const Challenge2Page({
    super.key,
    required this.onWebViewCreated,
  });

  @override
  State<Challenge2Page> createState() => _Challenge2PageState();
}

class _Challenge2PageState extends State<Challenge2Page> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => isLoading = true),
          onPageFinished: (_) => setState(() => isLoading = false),
          onNavigationRequest: (request) {
            // (Challenge 2 requirement)
            if (request.url.startsWith('https://docs.flutter.dev')) {
              return NavigationDecision.navigate;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://docs.flutter.dev'));

    widget.onWebViewCreated(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }
}
