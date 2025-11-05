import 'package:flutter/material.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/info_setting.dart/widgets/question_widget.dart';

class InfoSettingPage extends StatefulWidget {
  const InfoSettingPage({
    super.key,
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  State<InfoSettingPage> createState() => _InfoSettingPageState();
}

class _InfoSettingPageState extends State<InfoSettingPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: primaryColor),
      body: SingleChildScrollView(
        child: Column(
          spacing: Gap.md,
          children: [
            Container(
              width: double.infinity,
              color: primaryColor,
              padding: EdgeInsetsGeometry.fromLTRB(Gap.md, 0, Gap.md, Gap.lg),
              child: Column(
                spacing: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Thiết lập thông tin',
                    style: context.textTheme.titleSmall,
                  ),
                  Text(
                    'Thiết lập thông tin',
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
                  QuestionWidget(
                    email: widget.email,
                    password: widget.password,
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
