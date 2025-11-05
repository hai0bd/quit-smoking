import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/app_user.dart';
import 'package:quit_smoking/services/user_service.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();

  String _gender = 'Nam';
  File? _selectedImage;
  String? _avatarUrl;
  bool _loading = false;
  AppUser? _user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await UserService.getCurrentUserInfo();
    if (user != null) {
      setState(() {
        _user = user;
        _nameController.text = user.name;
        _ageController.text = user.age?.toString() ?? '';
        _gender = user.gender ?? 'Nam';
        _avatarUrl = user.avatarUrl;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() => _selectedImage = File(pickedFile.path));
    }
  }

  Future<void> _saveProfile(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    try {
      String? avatarUrl = _avatarUrl;
      if (_selectedImage != null) {
        avatarUrl = await UserService.uploadAvatarToCloudinary(_selectedImage!);
      }

      await UserService.updateUserInfo(
        name: _nameController.text.trim(),
        gender: _gender,
        age: int.parse(_ageController.text),
        avatarUrl: avatarUrl,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Cập nhật thành công!')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi: $e')));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      body: _user == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  color: Colors.white,
                  padding: EdgeInsetsGeometry.fromLTRB(
                    Gap.md,
                    0,
                    Gap.md,
                    Gap.lg,
                  ),
                  width: double.infinity,
                  child: Column(
                    spacing: Gap.sm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trang cá nhân',
                        style: context.textTheme.titleSmall,
                      ),
                      Text(
                        'Cập nhật thông tin của bạn',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingApp,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!)
                                : (_avatarUrl != null
                                          ? NetworkImage(_avatarUrl!)
                                          : null)
                                      as ImageProvider?,
                            child: _selectedImage == null && _avatarUrl == null
                                ? const Icon(Icons.camera_alt, size: 40)
                                : null,
                          ),
                        ),
                        Gap.mLHeight,
                        TextFieldApp(
                          controller: _nameController,
                          label: 'Họ tên',
                          validator: (value) => value == null || value.isEmpty
                              ? "Nhập tên"
                              : null,
                        ),
                        Gap.sMHeight,
                        TextFieldApp(
                          controller: _ageController,
                          label: 'Tuổi',
                          keyboardType: TextInputType.number,
                          validator: (value) => value == null || value.isEmpty
                              ? "Nhập tuổi"
                              : null,
                        ),
                        Gap.sMHeight,

                        // Giới tính
                        Padding(
                          padding: const EdgeInsets.only(bottom: Gap.sm),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Giới tính',
                              style: context.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                        DropdownButtonFormField<String>(
                          value: _gender,
                          items: const [
                            DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                            DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
                          ],
                          onChanged: (v) => setState(() => _gender = v!),
                          decoration: _buildInputBorder(),
                        ),
                        const SizedBox(height: 24),
                        ButtonApp(
                          onPressed: () {
                            _loading ? null : _saveProfile(context);
                          },
                          child: _loading
                              ? const CircularProgressIndicator()
                              : const Text("Lưu thay đổi"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _buildInputBorder() {
    return InputDecoration(
      fillColor: Color.fromARGB(255, 243, 243, 245),
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: radius16,
        borderSide: BorderSide(
          width: 1,
          color: Color.fromARGB(255, 107, 114, 128),
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: radius16,
        borderSide: BorderSide(
          width: 1,
          color: Color.fromARGB(255, 107, 114, 128),
        ),
      ),
    );
  }
}
