import 'package:flutter/material.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';

class ProgressBar extends StatelessWidget {
  final String title;
  final double percent;
  final Color color;

  const ProgressBar({
    super.key,
    required this.title,
    required this.percent,
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tiêu đề và phần trăm
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: context.textTheme.bodySmall),
            Text(
              '${(percent * 100).toInt()}%',
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 6),
        // Thanh tiến trình
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: percent,
            minHeight: 10,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ],
    );
  }
}
