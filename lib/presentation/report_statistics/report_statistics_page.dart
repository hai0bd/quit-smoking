import 'package:flutter/material.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/report_statistics/widgets/craving_chart_widget.dart';
import 'package:quit_smoking/presentation/report_statistics/widgets/report_summary.dart';
import 'package:quit_smoking/services/date_counter_service.dart';
import 'package:quit_smoking/services/sos_service.dart';
import 'package:quit_smoking/services/user_service.dart';

class ReportStatisticsPage extends StatefulWidget {
  const ReportStatisticsPage({super.key});

  @override
  State<ReportStatisticsPage> createState() => _ReportStatisticsPageState();
}

class _ReportStatisticsPageState extends State<ReportStatisticsPage> {
  Map<String, int> timeSinceQuit = {};
  int cravingCount = 0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    final dateQuite = await UserService.getUserQuitDate();
    timeSinceQuit = DateCounterService.getTimeSinceQuit(
      dateQuite ?? DateTime.now(),
    );
    cravingCount = await SOSService.getCravingCount();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsetsGeometry.fromLTRB(Gap.md, 0, Gap.md, Gap.lg),
              child: Column(
                spacing: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thống kê và báo cáo',
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Xem tiến độ của bạn',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: paddingApp,
              child: Column(
                spacing: Gap.md,
                children: [
                  ReportSummary(
                    cravingCount: cravingCount,
                    dateQuitCount: timeSinceQuit['days'] ?? 0,
                  ),
                  CravingChartWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
