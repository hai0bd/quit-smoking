import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/gap.dart';

class ReportSummary extends StatelessWidget {
  const ReportSummary({
    super.key,
    required this.cravingCount,
    required this.dateQuitCount,
  });

  final int dateQuitCount;
  final int cravingCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: Gap.md,
      children: [
        Expanded(
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 219, 234, 254),
              borderRadius: radius12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$dateQuitCount',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Color.fromARGB(255, 37, 99, 235),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap.mdHeight,
                Text(
                  'Tổng số ngày',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Color.fromARGB(255, 37, 99, 235),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 90,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 220, 252, 231),
              borderRadius: radius12,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$cravingCount',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Color.fromARGB(255, 22, 163, 74),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap.mdHeight,
                Text(
                  'Cơn thèm vượt qua',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: Color.fromARGB(255, 22, 163, 74),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
