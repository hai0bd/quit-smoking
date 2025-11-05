import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/services/auth_services.dart';

class ButtonLogout extends StatelessWidget {
  const ButtonLogout({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: borderColor, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: radius12),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        onPressed: () {
          AuthServices services = AuthServices();
          services.signOut(context);
        },
        label: Text(
          'Đăng xuất',
          style: context.textTheme.titleSmall?.copyWith(
            color: Colors.red,
            fontWeight: FontWeight.w700,
          ),
        ),
        icon: Icon(Icons.logout, color: Colors.red),
      ),
    );
  }
}
