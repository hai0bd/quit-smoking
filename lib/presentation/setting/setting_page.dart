import 'package:flutter/material.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/app_user.dart';
import 'package:quit_smoking/presentation/setting/widgets/account_setting.dart';
import 'package:quit_smoking/presentation/setting/widgets/button_logout.dart';
import 'package:quit_smoking/presentation/setting/widgets/profile_summary.dart';
import 'package:quit_smoking/services/local_storage.dart';
import 'package:quit_smoking/services/user_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  AppUser? user;

  @override
  void initState() {
    initData();
    super.initState();
  }

  Future<void> initData() async {
    user = await UserService.getCurrentUserInfo();
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
                  Text('Cài Đặt', style: context.textTheme.titleSmall),
                  Text(
                    'Quản lý tài khoản và ứng dụng',
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
                  ProfileSummary(user),
                  AccountSetting(
                    isNotice: LocalStorage.getBool(kNotification),
                    onTap: (value) async {
                      await LocalStorage.setBool(kNotification, value);
                      setState(() {});
                    },
                  ),
                  ButtonLogout(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
