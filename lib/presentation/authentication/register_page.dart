import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/info_setting.dart/info_setting_page.dart';
import 'package:quit_smoking/services/auth_services.dart';
import 'package:quit_smoking/services/dialog_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleRegister(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirm = _confirmController.text.trim();

    if (email.isEmpty || password.isEmpty || confirm.isEmpty) {
      await DialogService.showError(
        context,
        'Thiếu thông tin',
        'Vui lòng nhập đầy đủ các trường.',
      );
      return;
    }

    if (password != confirm) {
      await DialogService.showError(
        context,
        'Mật khẩu không khớp',
        'Vui lòng kiểm tra lại.',
      );
      return;
    }

    setState(() => _isLoading = true);

    final checkEmailExists = await AuthServices.checkEmailExists(email);
    setState(() => _isLoading = false);

    if (checkEmailExists) {
      await DialogService.showError(context, 'Lỗi đăng ký', 'Email đã tồn tại');
    } else {
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoSettingPage(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: paddingApp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap.xlHeight,
              Text(
                'Tạm biệt thuốc lá',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              Gap.sMHeight,
              Text(
                'Chào mừng bạn bắt đầu hành trình mới!',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: secondaryColor,
                ),
              ),
              Gap.xxxlHeight,
              TextFieldApp(
                controller: _emailController,
                hintText: 'email@example.com',
                label: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              Gap.mdHeight,
              TextFieldApp(
                controller: _passwordController,
                hintText: '**************',
                label: 'Mật khẩu',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
              ),
              Gap.mdHeight,
              TextFieldApp(
                controller: _confirmController,
                hintText: '**************',
                label: 'Xác nhận mật khẩu',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
              ),
              Gap.xxlHeight,
              ButtonApp(
                borderRadius: radius16,
                onPressed: () {
                  _isLoading ? null : _handleRegister(context);
                },
                child: Text('Đăng ký'),
              ),
              Gap.mLHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Đã có tài khoản?', style: context.textTheme.bodyMedium),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Đăng nhập',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Gap.xlHeight,
            ],
          ),
        ),
      ),
    );
  }
}
