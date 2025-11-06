import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/app_user.dart';
import 'package:quit_smoking/presentation/setting/setting_page.dart';

class WelcomeHome extends StatelessWidget {
  const WelcomeHome(this.user, {super.key});

  final AppUser? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Xin chào, ${user?.name}', style: context.textTheme.bodySmall),
            Gap.smHeight,
            Text(
              'Xin chào, ${user?.name}',
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingPage()),
            );
          },
          child: SvgPicture.asset('assets/images/setting.svg'),
        ),
      ],
    );
  }
}
