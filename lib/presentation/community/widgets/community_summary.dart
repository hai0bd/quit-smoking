import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';

class CommunitySummary extends StatelessWidget {
  const CommunitySummary({
    super.key,
    required this.totalLike,
    required this.totalPost,
    required this.totalUser,
  });

  final int totalUser;
  final int totalPost;
  final int totalLike;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
        borderRadius: radius16,
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(180, 160, 234, 207),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    totalUser.toString(),
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Thành viên',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Color.fromARGB(178, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Column(
                children: [
                  Text(
                    totalPost.toString(),
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Bài viết',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Color.fromARGB(178, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            VerticalDivider(),
            Expanded(
              child: Column(
                children: [
                  Text(
                    totalLike.toString(),
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Tương tác',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Color.fromARGB(178, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
