import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/authentication/register_page.dart';
import 'package:quit_smoking/presentation/authentication/reset_password_page.dart';
import 'package:quit_smoking/presentation/home/home_page.dart';
import 'package:quit_smoking/services/auth_services.dart';
import 'package:quit_smoking/services/dialog_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController(text: 'mylam@gmail.com');
  final _passwordController = TextEditingController(text: '123456');
  bool _isLoading = false;
  final _auth = AuthServices();

  Future<void> _handleLogin(BuildContext context) async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      await DialogService.showError(
        context,
        'Thiếu thông tin',
        'Vui lòng nhập email và mật khẩu.',
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await _auth.signIn(email: email, password: password);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        await DialogService.showError(
          context,
          'Lỗi đăng nhập',
          e.message.toString(),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                'Chào mừng bạn trở lại!',
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
              Gap.lgHeight,
              TextFieldApp(
                controller: _passwordController,
                hintText: '**************',
                label: 'Mật khẩu',
                obscureText: true,
                prefixIcon: const Icon(Icons.lock_outline_rounded),
              ),

              Gap.sMHeight,
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordPage(),
                      ),
                    );
                  },
                  child: Text(
                    'Quên mật khẩu?',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              Gap.xxlHeight,
              ButtonApp(
                onPressed: () {
                  _isLoading ? null : _handleLogin(context);
                },
                borderRadius: radius16,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text('Đăng nhập'),
              ),

              Gap.mLHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chưa có tài khoản?',
                    style: context.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const RegisterPage()),
                      );
                    },
                    child: Text(
                      'Đăng ký ngay',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
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
