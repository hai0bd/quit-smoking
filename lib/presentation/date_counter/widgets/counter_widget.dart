import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/services/date_counter_service.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({super.key, required this.quitDate});

  final DateTime quitDate;

  @override
  Widget build(BuildContext context) {
    final Map<String, int> time = DateCounterService.getTimeSinceQuit(quitDate);

    return Row(
      spacing: Gap.md,
      children: [
        _buildItem(
          context,
          Color.fromARGB(255, 160, 234, 207),
          time['days'] ?? 0,
          'Ngày',
        ),
        _buildItem(
          context,
          Color.fromARGB(255, 224, 231, 255),
          time['hours'] ?? 0,
          'Giờ',
        ),
        _buildItem(
          context,
          Color.fromARGB(255, 252, 231, 243),
          time['minutes'] ?? 0,
          'Phút',
        ),
        _buildItem(
          context,
          Color.fromARGB(255, 254, 226, 226),
          time['seconds'] ?? 0,
          'Giây',
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, Color color, int value, String text) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Gap.md, vertical: Gap.sM),
        decoration: BoxDecoration(color: color, borderRadius: radius16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$value', style: context.textTheme.bodyMedium),
            Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: Color.fromARGB(163, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
