import 'package:flutter/material.dart';
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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        children: const [
          Challenge1Page(),
          Challenge2Page(),
          Challenge3Page(),
        ],
      ),
      bottomNavigationBar: AnimatedBottomBar(
        currentIndex: currentIndex,
        onTap: onTabTap,
      ),
    );
  }
}
