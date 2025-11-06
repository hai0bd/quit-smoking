import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/community/community_page.dart';
import 'package:quit_smoking/presentation/emotional_diary/emotional_diary_page.dart';
import 'package:quit_smoking/presentation/date_counter/date_counter_page.dart';
import 'package:quit_smoking/presentation/health_progress/health_progress_page.dart';
import 'package:quit_smoking/presentation/report_statistics/report_statistics_page.dart';
import 'package:quit_smoking/presentation/sos/sos_page.dart';

class QuickAccess extends StatelessWidget {
  const QuickAccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Gap.md, top: Gap.sm),
          child: Text('Truy cập nhanh', style: context.textTheme.bodySmall),
        ),
        Row(
          children: [
            _buildItem(context, 'assets/images/clock_item.svg', 'Bộ đếm', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DateCounterPage()),
              );
            }),
            _buildItem(context, 'assets/images/heart_item.svg', 'Sức khỏe', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HealthProgressPage()),
              );
            }),
            _buildItem(context, 'assets/images/goal_item.svg', 'Bộ đếm', () {}),
            _buildItem(
              context,
              'assets/images/emotion_item.svg',
              'Cảm xúc',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmotionalDiaryPage()),
                );
              },
            ),
          ],
        ),
        Row(
          children: [
            _buildItem(context, 'assets/images/warning_item.svg', 'SOS', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SosPage()),
              );
            }),
            _buildItem(
              context,
              'assets/images/growth_item.svg',
              'Thống kê',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportStatisticsPage(),
                  ),
                );
              },
            ),
            _buildItem(
              context,
              'assets/images/people_item.svg',
              'Cộng đồng',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommunityPage()),
                );
              },
            ),
            _buildItem(
              context,
              'assets/images/gift_item.svg',
              'Phần thưởng',
              () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    String item,
    String label,
    VoidCallback? onTap,
  ) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            SvgPicture.asset(item),
            Gap.xsHeight,
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
