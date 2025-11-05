import 'package:flutter/material.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/community_post_model.dart';
import 'package:quit_smoking/presentation/community/widgets/post_item.dart';

class ListPost extends StatelessWidget {
  const ListPost(this.posts, {super.key});

  final List<CommunityPostModel> posts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: posts.length,
        separatorBuilder: (context, index) => Gap.sMHeight,
        itemBuilder: (context, index) {
          final post = posts[index];
          return PostItem(post);
        },
      ),
    );
  }
}
