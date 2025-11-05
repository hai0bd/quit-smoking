import 'package:flutter/material.dart';

class SimpleProgressBar extends StatelessWidget {
  final double progress; // 0.0 → 1.0

  const SimpleProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 8,
        color: Colors.black,
        backgroundColor: Color.fromARGB(255, 188, 191, 196),
      ),
    );
  }
}
