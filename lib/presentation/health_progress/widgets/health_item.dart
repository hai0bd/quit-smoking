import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/simple_progress_bar.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/formatter.dart';
import 'package:quit_smoking/configs/gap.dart';

class HealthItem extends StatelessWidget {
  const HealthItem({
    super.key,
    required this.category,
    required this.health,
    required this.subtitle,
    required this.title,
    required this.icon,
  });

  final double health;
  final String category;
  final String title;
  final String subtitle;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
        color: Colors.white,
        borderRadius: radius12,
      ),
      child: Row(
        spacing: Gap.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          Expanded(
            child: Column(
              spacing: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      category,
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      Formatter.formatPercent(health),
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: textColor,
                  ),
                ),
                SimpleProgressBar(progress: health / 100),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
