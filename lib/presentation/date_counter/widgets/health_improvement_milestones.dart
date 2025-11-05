import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/services/date_counter_service.dart';

class HealthImprovementMilestones extends StatelessWidget {
  const HealthImprovementMilestones({super.key, required this.quitDate});

  final DateTime quitDate;

  @override
  Widget build(BuildContext context) {
    final Map<String, int> time = DateCounterService.getTimeSinceQuit(quitDate);

    final int day = time['days'] ?? 0;
    final int hours = time['hours'] ?? 0;
    final int minutes = time['minutes'] ?? 0;

    final int total = minutes + hours * 60 + day * 1440;

    return Padding(
      padding: const EdgeInsets.all(Gap.md),
      child: Column(
        spacing: Gap.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Các mốc cải thiện sức khỏe',
            style: context.textTheme.titleSmall,
          ),
          _buildItem(
            context,
            "20 phút",
            "Nhịp tim bắt đầu bình thường",
            total >= 20,
          ),
          _buildItem(
            context,
            "12 giờ",
            "Lượng CO trong máu giảm",
            total >= 720,
          ),
          _buildItem(
            context,
            "2 tuần",
            "Tuần hoàn và phổi cải thiện",
            total >= 20160,
          ),
          _buildItem(
            context,
            "1 tháng",
            "Ho và khó thở giảm rõ rệt",
            total >= 43200,
          ),
          _buildItem(
            context,
            "3 tháng",
            "Nguy cơ đau tim giảm",
            total >= 129600,
          ),
          _buildItem(
            context,
            "1 năm",
            "Nguy cơ bệnh tim giảm",
            total >= 518400,
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String title,
    String subTitle,
    bool isAttend,
  ) {
    return Container(
      padding: EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
        color: Colors.white,
        borderRadius: radius12,
      ),
      child: Row(
        spacing: Gap.md,
        children: [
          SvgPicture.asset(
            'assets/images/${isAttend ? 'check_tick' : 'check_dot'}.svg',
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subTitle,
                style: context.textTheme.bodySmall?.copyWith(color: textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
