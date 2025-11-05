import 'package:flutter/material.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/health_progress/widgets/health_item.dart';
import 'package:quit_smoking/presentation/health_progress/widgets/health_summary.dart';
import 'package:quit_smoking/services/health_progress_service.dart';
import 'package:quit_smoking/services/user_service.dart';

class HealthProgressPage extends StatefulWidget {
  const HealthProgressPage({super.key});

  @override
  State<HealthProgressPage> createState() => _HealthProgressPageState();
}

class _HealthProgressPageState extends State<HealthProgressPage> {
  DateTime? quitDate;
  int daysSinceQuit = 0;
  Map<String, double> data = {};

  @override
  void initState() {
    initDate();
    super.initState();
  }

  Future<void> initDate() async {
    quitDate = await UserService.getUserQuitDate();
    data = HealthProgressService.calculateHealthProgress(
      quitDate ?? DateTime.now(),
    );
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
                  Text(
                    'Theo dõi sức khỏe',
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Cơ thể đang phục hồi',
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
                  HealthSummary(data['avge'] ?? 0),
                  HealthItem(
                    category: 'Phổi',
                    health: data['lung'] ?? 0,
                    subtitle: 'Khả năng hô hấp đang dần phục hồi',
                    title: 'Chức năng phổi cải thiện 75%',
                    icon: 'assets/images/person.svg',
                  ),
                  HealthItem(
                    category: 'Tim mạch',
                    health: data['heart'] ?? 0,
                    subtitle: 'Nguy cơ bệnh tim đang giảm',
                    title: 'Huyết áp ổn định hơn',
                    icon: 'assets/images/heart_rate.svg',
                  ),
                  HealthItem(
                    category: 'Năng lượng',
                    health: data['energy'] ?? 0,
                    subtitle: 'Cơ thể đang dần lấy lại sức sống',
                    title: 'Năng lượng tăng 85%',
                    icon: 'assets/images/energy.svg',
                  ),
                  HealthItem(
                    category: 'Giấc ngủ',
                    health: data['sleep'] ?? 0,
                    subtitle: 'Ngủ sâu và dễ dàng hơn',
                    title: 'Chất lượng giấc mơ tốt hơn',
                    icon: 'assets/images/sleep.svg',
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
