import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/gap.dart';

class TodayAdvice extends StatelessWidget {
  const TodayAdvice({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Gap.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Gap.sm,
        children: [
          Text('Sức khỏe đang cải thiện', style: context.textTheme.titleSmall),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Gap.md),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color.fromARGB(177, 160, 234, 207), Colors.white],
              ),
              borderRadius: radius12,
              border: Border.all(
                width: 1,
                color: Color.fromARGB(255, 154, 158, 168),
              ),
            ),
            child: Text(
              'Hít thở sâu 5 lần khi cảm thấy thèm\nthuốc. Điều này sẽ giúp bạn thư giãn và\ngiảm cơn thèm.',
            ),
          ),
        ],
      ),
    );
  }
}
