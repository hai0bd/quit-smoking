import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/progress_bar.dart';
import 'package:quit_smoking/configs/gap.dart';

class HealthCondition extends StatelessWidget {
  const HealthCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Gap.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Gap.sM,
        children: [
          Text('Sức khỏe đang cải thiện', style: context.textTheme.bodySmall),
          Container(
            padding: EdgeInsets.all(Gap.md),
            decoration: BoxDecoration(
              borderRadius: radius12,
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 154, 158, 168),
              ),
            ),
            child: Column(
              spacing: Gap.md,
              children: [
                ProgressBar(title: 'Phổi', percent: 0.75),
                ProgressBar(
                  title: 'Tim mạch',
                  percent: 0.60,
                  color: Colors.red,
                ),
                ProgressBar(
                  title: 'Năng lượng',
                  percent: 0.85,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
