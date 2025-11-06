import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/simple_progress_bar.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/formatter.dart';
import 'package:quit_smoking/configs/gap.dart';

class HealthSummary extends StatelessWidget {
  const HealthSummary(this.avge, {super.key});

  final double avge;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        color: appColor,
        borderRadius: radius12,
        border: Border.all(width: 1, color: borderColor),
      ),
      child: Column(
        spacing: Gap.md,
        children: [
          Text(
            'Tổng quan sức khỏe',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),

          Text(
            '28 ngày không hút thuốc',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 13,
              color: textColor,
            ),
          ),
          Container(
            padding: EdgeInsets.all(Gap.md),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: radius12,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Cải thiện chung',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: textColor,
                      ),
                    ),
                    Spacer(),
                    Text(
                      Formatter.formatPercent(avge),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: textColor,
                      ),
                    ),
                  ],
                ),
                Gap.mdHeight,
                SimpleProgressBar(progress: avge / 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
