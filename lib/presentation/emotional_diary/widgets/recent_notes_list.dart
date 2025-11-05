import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/formatter.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/emotion_model.dart';

class RecentNotesList extends StatelessWidget {
  const RecentNotesList(this.emotions, {super.key});

  final List<EmotionModel> emotions;

  @override
  Widget build(BuildContext context) {
    final icon = {
      'Vui vẻ': 'assets/images/emotion1.svg',
      'Bình thản': 'assets/images/emotion2.svg',
      'Buồn': 'assets/images/emotion3.svg',
      'Căng thẳng': 'assets/images/emotion4.svg',
      'Tự hào': 'assets/images/emotion5.svg',
      'Lo lắng': 'assets/images/emotion6.svg',
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: Gap.md),
          child: Text('Ghi chú gần đây', style: context.textTheme.titleSmall),
        ),
        ListView.builder(
          itemCount: emotions.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = emotions[index];
            return Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: Gap.sM),
              padding: EdgeInsets.all(Gap.sM),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1, color: borderColor),
                borderRadius: radius12,
              ),
              child: Column(
                spacing: Gap.md,
                children: [
                  Row(
                    spacing: Gap.md,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: radius16,
                        child: SvgPicture.asset(
                          icon[item.typeEmotion] ??
                              'assets/images/emotion1.svg',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Text(
                        item.typeEmotion,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Text(
                        Formatter.formatDateTime(item.createdAt),
                        style: context.textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(153, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    item.content,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(143, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
