import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Challenge3Page extends StatefulWidget {
  const Challenge3Page({super.key, required this.onWebViewCreated});
  final Function(WebViewController) onWebViewCreated;
  @override
  State<Challenge3Page> createState() => _Challenge3PageState();
}

class _Challenge3PageState extends State<Challenge3Page> {
  late final WebViewController _controller;
  int totalFromJs = 0;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'FlutterChannel',
        onMessageReceived: (message) {
          setState(() {
            totalFromJs = int.parse(message.message);
          });
        },
      )
      ..loadFlutterAsset('assets/webview.html');
  widget.onWebViewCreated(_controller);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebView JS Example')),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: _controller)),

          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey.shade200,
            child: Column(
              children: [
                Text(
                  'Received from JS: $totalFromJs',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    _controller.runJavaScript(
                      'updateTotalFromFlutter(${totalFromJs + 100});',
                    );
                  },
                  child: const Text('Send +100 total from Flutter to JS'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    // รีเซ็ตค่าใน Flutter
                    setState(() {
                      totalFromJs = 0;
                    });

                    // ส่งค่า 0 ไปให้ JS
                    _controller.runJavaScript('updateTotalFromFlutter(0);');
                  },
                  child: const Text('Reset total to 0'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
