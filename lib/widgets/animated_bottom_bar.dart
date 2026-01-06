import 'package:flutter/material.dart';

class AnimatedBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(3, (index) {
          final bool isActive = index == currentIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(
                horizontal: isActive ? 22 : 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: isActive ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    index == 0
                        ? Icons.home
                        : index == 1
                            ? Icons.web
                            : Icons.javascript,
                    color: isActive ? Colors.blue : Colors.white,
                  ),
                  if (isActive)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        index == 0
                            ? 'Home'
                            : index == 1
                                ? 'WebView'
                                : 'JS',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
