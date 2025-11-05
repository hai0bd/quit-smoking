import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/date_counter/widgets/counter_widget.dart';
import 'package:quit_smoking/presentation/date_counter/widgets/health_improvement_milestones.dart';
import 'package:quit_smoking/services/user_service.dart';

class DateCounterPage extends StatefulWidget {
  const DateCounterPage({super.key});

  @override
  State<DateCounterPage> createState() => _DateCounterPageState();
}

class _DateCounterPageState extends State<DateCounterPage> {
  DateTime? quitDate;

  @override
  void initState() {
    initDate();
    super.initState();
  }

  Future<void> initDate() async {
    quitDate = await UserService.getUserQuitDate();
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
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsetsGeometry.fromLTRB(Gap.md, 0, Gap.md, Gap.lg),
              child: Column(
                spacing: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bộ đếm thời gian', style: context.textTheme.titleSmall),
                  Text(
                    'Thời gian bạn không hút thuốc',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Container(
              width: double.infinity,
              padding: paddingApp,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Gap.md),
                    decoration: BoxDecoration(
                      color: appColor,
                      borderRadius: radius12,
                      border: Border.all(width: 1, color: borderColor),
                    ),
                    child: Column(
                      spacing: Gap.md,
                      children: [
                        SvgPicture.asset('assets/images/cup.svg'),
                        Text(
                          'Không hút thuốc được',
                          style: context.textTheme.bodyMedium,
                        ),
                        CounterWidget(quitDate: quitDate ?? DateTime.now()),
                      ],
                    ),
                  ),
                  HealthImprovementMilestones(
                    quitDate: quitDate ?? DateTime.now(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
