import 'package:flutter/material.dart';
import 'package:quit_smoking/models/app_user.dart';
import 'package:quit_smoking/presentation/home/widgets/health_condition.dart';
import 'package:quit_smoking/presentation/home/widgets/quick_access.dart';
import 'package:quit_smoking/presentation/home/widgets/summary_home.dart';
import 'package:quit_smoking/presentation/home/widgets/today_advice.dart';
import 'package:quit_smoking/services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppUser? user;

  initData() async {
    user = await UserService.getCurrentUserInfo();
    setState(() {});
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SummaryHome(user),
              HealthCondition(),
              QuickAccess(),
              TodayAdvice(),
            ],
          ),
        ),
      ),
    );
  }
}
