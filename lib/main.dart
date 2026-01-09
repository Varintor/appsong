import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'pages/challenge1_page.dart';
import 'pages/challenge2_page.dart';
import 'pages/challenge3_page.dart';
import 'widgets/animated_bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeWithBar(),
    );
  }
}

class HomeWithBar extends StatefulWidget {
  const HomeWithBar({super.key});

  @override
  State<HomeWithBar> createState() => _HomeWithBarState();
}

class _HomeWithBarState extends State<HomeWithBar> {
  int currentIndex = 0;
  final PageController _pageController = PageController();

  WebViewController? activeController;

  void onTabTap(int index) {
    setState(() => currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          currentIndex == 0
              ? 'Challenge 1 - WebView'
              : currentIndex == 1
                  ? 'Challenge 2 - Navigation'
                  : 'Challenge 3 - JS ↔ Flutter',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (activeController != null &&
                  await activeController!.canGoBack()) {
                activeController!.goBack();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () async {
              if (activeController != null &&
                  await activeController!.canGoForward()) {
                activeController!.goForward();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              activeController?.reload();
            },
          ),
        ],
      ),

      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        children: [
          Challenge1Page(
            onWebViewCreated: (controller) {
              activeController = controller;
            },
          ),
          Challenge2Page(
            onWebViewCreated: (controller) {
              activeController = controller;
            },
          ),
          Challenge3Page(
            onWebViewCreated: (controller) {
              activeController = controller;
            },
          ),
        ],
      ),

      bottomNavigationBar: AnimatedBottomBar(
        currentIndex: currentIndex,
        onTap: onTabTap,
      ),
    );
  }
}
