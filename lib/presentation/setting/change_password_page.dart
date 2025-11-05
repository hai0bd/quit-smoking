import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  final _auth = FirebaseAuth.instance;

  Future<void> _changePassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception("Không tìm thấy người dùng.");

      // Re-authenticate user before changing password
      final cred = EmailAuthProvider.credential(
        email: user.email!,
        password: _currentPasswordController.text,
      );

      await user.reauthenticateWithCredential(cred);

      if (_newPasswordController.text != _confirmPasswordController.text) {
        throw Exception("Mật khẩu xác nhận không khớp.");
      }

      await user.updatePassword(_newPasswordController.text);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Đổi mật khẩu thành công!")),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String message = "Lỗi không xác định";
      if (e.code == 'invalid-credential') {
        message = 'Mật khẩu hiện tại không chính xác';
      } else if (e.code == 'wrong-password') {
        message = "Mật khẩu hiện tại không đúng.";
      } else if (e.code == 'weak-password') {
        message = "Mật khẩu mới quá yếu.";
      } else if (e.code == 'requires-recent-login') {
        message = "Vui lòng đăng nhập lại để đổi mật khẩu.";
      }
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Đổi mật khẩu',
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldApp(
                controller: _currentPasswordController,
                obscureText: true,
                label: "Mật khẩu hiện tại",

                validator: (value) =>
                    value!.isEmpty ? "Vui lòng nhập mật khẩu hiện tại" : null,
              ),
              const SizedBox(height: 16),
              TextFieldApp(
                controller: _newPasswordController,
                obscureText: true,
                label: "Mật khẩu mới",
                validator: (value) {
                  if (value!.isEmpty) return "Vui lòng nhập mật khẩu mới";
                  if (value.length < 6) {
                    return "Mật khẩu phải có ít nhất 6 ký tự";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFieldApp(
                controller: _confirmPasswordController,
                obscureText: true,
                label: 'Xác nhận mật khẩu mới',
                validator: (value) {
                  if (value!.isEmpty) return "Vui lòng xác nhận mật khẩu mới";
                  if (value != _newPasswordController.text) {
                    return "Mật khẩu không khớp";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ButtonApp(
                onPressed: () {
                  _isLoading ? null : _changePassword(context);
                },
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Đổi mật khẩu"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
