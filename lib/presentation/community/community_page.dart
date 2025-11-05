import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/community_post_model.dart';
import 'package:quit_smoking/presentation/community/add_post_page.dart';
import 'package:quit_smoking/presentation/community/widgets/community_summary.dart';
import 'package:quit_smoking/presentation/community/widgets/list_post.dart';
import 'package:quit_smoking/services/community_service.dart';
import 'package:quit_smoking/services/user_service.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int totalUser = 0;
  int totalPost = 0;
  int totalLike = 0;
  List<CommunityPostModel> posts = [];

  StreamSubscription? _stream;

  @override
  void initState() {
    super.initState();
    intiData();
    initStream();
  }

  Future<void> intiData() async {
    totalLike = await CommunityService.getTotalLikeCount();
    totalPost = await CommunityService.getTotalPostCount();
    totalUser = await UserService.getTotalUserCount();
    setState(() {});
  }

  void initStream() {
    _stream = CommunityService.getPosts().listen((event) {
      setState(() {
        posts = event;
      });
    });
  }

  @override
  void dispose() {
    _stream?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsetsGeometry.fromLTRB(Gap.md, 0, Gap.md, Gap.lg),
            child: Column(
              spacing: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cộng đồng', style: context.textTheme.titleSmall),
                    _buildButtonAddPost(),
                  ],
                ),
                Text('Kết nối và chia sẻ', style: context.textTheme.bodySmall),
              ],
            ),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: paddingApp,
              child: Column(
                spacing: Gap.md,
                children: [
                  CommunitySummary(
                    totalLike: totalLike,
                    totalPost: totalPost,
                    totalUser: totalUser,
                  ),
                  ListPost(posts),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonAddPost() {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddPostPage()),
        );
        intiData();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Gap.sm, horizontal: Gap.sM),
        decoration: BoxDecoration(color: appColor, borderRadius: radius100),
        child: Row(
          children: [
            Icon(Icons.add, size: Gap.md),
            Text(
              ' Đăng',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
