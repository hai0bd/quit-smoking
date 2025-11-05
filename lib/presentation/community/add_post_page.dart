import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/formatter.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/app_user.dart';
import 'package:quit_smoking/services/community_service.dart';
import 'package:quit_smoking/services/dialog_service.dart';
import 'package:quit_smoking/services/user_service.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  AppUser? user;
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tạo bài viết',
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              padding: paddingApp,
              child: Column(
                spacing: Gap.md,
                children: [
                  Container(
                    padding: EdgeInsets.all(Gap.md),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: borderColor),
                      borderRadius: radius12,
                    ),
                    child: Column(
                      spacing: Gap.md,
                      children: [_buildInfoUser(context), _buildTextField()],
                    ),
                  ),

                  ButtonApp(
                    onPressed: () async {
                      await addPost(context);
                    },
                    child: _loading
                        ? Center(child: CircularProgressIndicator())
                        : Text(
                            'Đăng bài ',
                            style: context.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> addPost(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      if (!_loading) {
        try {
          setState(() {
            _loading = true;
          });
          await CommunityService.addPost(_controller.text);
          setState(() {
            _loading = false;
          });
          if (context.mounted) {
            await DialogService.showSuccess(
              context,
              'Thành công',
              'Thêm bài đăng thành công',
            );
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        } catch (e) {
          setState(() {
            _loading = false;
          });
        } finally {
          setState(() {
            _loading = false;
          });
        }
      }
    }
  }

  Widget _buildTextField() {
    return Form(
      key: _formKey,
      child: TextFieldApp(
        controller: _controller,
        hintText: 'Viết ghi chú về cảm xúc của bạn...',
        maxLines: 5,
        fillColor: const Color.fromARGB(20, 0, 0, 0),
        maxLength: 500,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Điền trạng thái của bạn';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildInfoUser(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        spacing: Gap.sM,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: appColor),
            child: Center(
              child: Text(
                Formatter.getInitials(user!.name),
                style: context.textTheme.titleSmall?.copyWith(fontSize: 13),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user!.name,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Chia sẻ lên cộng đồng',
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
