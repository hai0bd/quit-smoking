import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/services/auth_services.dart';
import 'package:quit_smoking/services/dialog_service.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    super.key,
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int cigarettesPerDay = 0;
  int cigarettesPerPack = 0;
  int packPrice = 0;
  int yearsSmoked = 0;

  final questions = [
    'Bạn hút bao nhiêu điếu mỗi ngày?',
    'Giá một gói thuốc là bao nhiêu?',
    'Một gói có bao nhiêu điếu?',
    'Bạn đã hút thuốc bao lâu?',
  ];

  final descriptions = [
    'Trung bình trong thời gian gần đây',
    'Loại thuốc bạn thường hút',
    'Thông tin này giúp tính toán chính xác hơn',
    'Tính từ khi bắt đầu hút đều đặn',
  ];

  final labels = [
    'Số điếu/ngày',
    'Giá tiền (VND)',
    'Số điếu mỗi gói',
    'Số năm',
  ];

  final hints = ['Ví dụ: 10', 'Ví dụ: 35000', 'Ví dụ: 20', 'Ví dụ: 5'];

  int index = 0;

  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  register(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      await AuthServices().signUp(
        email: widget.email,
        password: widget.password,
        name: widget.email.split('@')[0],
        cigarettesPerDay: cigarettesPerDay,
        cigarettesPerPack: cigarettesPerPack,
        packPrice: packPrice,
        yearsSmoked: yearsSmoked,
      );
      if (context.mounted) {
        await DialogService.showSuccess(
          context,
          'Đăng ký thành công',
          'Chào mừng bạn đến với Tạm Biệt Thuốc Lá!',
        );
        if (context.mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        await DialogService.showError(context, 'Lỗi đăng ký', e.toString());
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Gap.md,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(Gap.md),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: radius12,
          ),
          child: Column(
            children: [
              Text(questions[index], style: context.textTheme.titleSmall),
              Gap.mdHeight,
              Text(
                questions[index],
                style: context.textTheme.bodySmall?.copyWith(color: textColor),
              ),
              Gap.lgHeight,

              Form(
                key: _formKey,
                child: TextFieldApp(
                  label: labels[index],
                  hintText: hints[index],
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng điền thông tin để tiếp tục';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ),

        ButtonApp(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Text('Tiếp tục'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (index < 3) {
                if (index == 0) {
                  cigarettesPerDay = int.parse(_controller.text);
                } else if (index == 1) {
                  packPrice = int.parse(_controller.text);
                } else if (index == 2) {
                  cigarettesPerPack = int.parse(_controller.text);
                }
                _controller.clear();
                setState(() {
                  index++;
                });
              } else if (index == 3) {
                yearsSmoked = int.parse(_controller.text);
                register(context);
              }
            }
          },
        ),
        if (index > 0)
          ButtonApp(
            backgroundColor: Colors.white,
            child: Text('Quay lại'),
            onPressed: () {
              setState(() {
                index--;
              });
              if (index == 0) {
                _controller.text = cigarettesPerDay.toString();
              } else if (index == 1) {
                _controller.text = packPrice.toString();
              } else if (index == 2) {
                _controller.text = cigarettesPerPack.toString();
              }
            },
          ),
      ],
    );
  }
}
