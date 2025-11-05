import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/setting/change_password_page.dart';
import 'package:quit_smoking/presentation/setting/profile_edit_page.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({
    super.key,
    required this.isNotice,
    required this.onTap,
  });

  final bool isNotice;
  final Future<void> Function(bool) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
        borderRadius: radius12,
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditPage()),
              );
            },
            dense: true,
            title: Text('Thông tin cá nhân'),
            leading: Icon(Icons.person_outline_rounded),
            trailing: Icon(Icons.arrow_forward_ios_sharp, size: Gap.md),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Gap.md),
            child: Divider(height: 1),
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordPage()),
              );
            },
            dense: true,
            title: Text('Mật khẩu & bảo mật'),
            leading: Icon(Icons.lock_outline_sharp),
            trailing: Icon(Icons.arrow_forward_ios_sharp, size: Gap.md),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Gap.md),
            child: Divider(height: 1),
          ),
          ListTile(
            dense: true,
            title: Text('Nhắc nhở hằng ngày'),
            leading: Icon(Icons.notifications_active_outlined),
            trailing: Switch(
              value: !isNotice,
              onChanged: (value) {
                onTap.call(!value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
