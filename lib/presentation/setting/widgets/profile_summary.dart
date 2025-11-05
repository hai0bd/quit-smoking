import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/app_user.dart';

class ProfileSummary extends StatelessWidget {
  const ProfileSummary(this.user, {super.key});

  final AppUser? user;

  @override
  Widget build(BuildContext context) {
    return user == null
        ? Center(child: CircularProgressIndicator())
        : Container(
            padding: EdgeInsets.all(Gap.md),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: borderColor),
              borderRadius: radius12,
            ),
            child: IntrinsicHeight(
              child: Row(
                spacing: Gap.md,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColor,
                    ),
                    child: user!.avatarUrl == null
                        ? Icon(Icons.person_outline_sharp, size: 25)
                        : ClipRRect(
                            borderRadius: radius100,
                            child: Image.network(
                              user!.avatarUrl!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user!.name,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        user!.email,
                        style: context.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      Text(
                        'Thành viên từ ${DateFormat('yyyy/MM/dd').format(user!.createdAt)}',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: appColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
