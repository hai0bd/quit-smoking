import 'package:flutter/material.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';
import 'package:quit_smoking/services/auth_services.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Đặt lại mật khẩu',
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFieldApp(
              controller: _emailController,
              label: 'Email',
              hintText: 'Nhập email của bạn',
            ),
            const SizedBox(height: 20),
            ButtonApp(
              onPressed: () {
                final email = _emailController.text.trim();
                if (email.isNotEmpty) {
                  _auth.resetPassword(context, email);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Vui lòng nhập email'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Gửi yêu cầu đặt lại'),
            ),
          ],
        ),
      ),
    );
  }
}
