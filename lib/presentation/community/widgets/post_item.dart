import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/formatter.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/community_post_model.dart';

class PostItem extends StatelessWidget {
  const PostItem(this.post, {super.key});

  final CommunityPostModel post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: borderColor),
        borderRadius: radius12,
      ),
      child: Column(
        spacing: Gap.md,
        mainAxisSize: MainAxisSize.min,
        children: [
          IntrinsicHeight(
            child: Row(
              spacing: Gap.sM,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: appColor,
                  ),
                  child: Center(
                    child: Text(
                      Formatter.getInitials(post.userName),
                      style: context.textTheme.titleSmall?.copyWith(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userName,
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      Formatter.timeAgo(post.createdAt),
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 10,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Text(
            post.content,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          // Divider(height: 1),
          // Row(
          //   spacing: Gap.sm,
          //   children: [
          //     InkWell(
          //       onTap: () {},
          //       child: Icon(Icons.favorite, color: Colors.red),
          //     ),
          //     Text(
          //       post.likes.length.toString(),
          //       style: context.textTheme.bodyMedium?.copyWith(color: textColor),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
