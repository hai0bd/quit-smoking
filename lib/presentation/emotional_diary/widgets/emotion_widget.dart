import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/common/widgets/text_field_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/services/emotion_service.dart';
import 'package:quit_smoking/services/dialog_service.dart';

class EmotionWidget extends StatefulWidget {
  const EmotionWidget({super.key});

  @override
  State<EmotionWidget> createState() => _EmotionWidgetState();
}

class _EmotionWidgetState extends State<EmotionWidget> {
  String? selectedEmotion;
  bool _isLoading = false;
  final TextEditingController _noteController = TextEditingController();

  final List<Map<String, String>> emotions = [
    {'asset': 'assets/images/emotion1.svg', 'type': 'Vui vẻ'},
    {'asset': 'assets/images/emotion2.svg', 'type': 'Bình thản'},
    {'asset': 'assets/images/emotion3.svg', 'type': 'Buồn'},
    {'asset': 'assets/images/emotion4.svg', 'type': 'Căng thẳng'},
    {'asset': 'assets/images/emotion5.svg', 'type': 'Tự hào'},
    {'asset': 'assets/images/emotion6.svg', 'type': 'Lo lắng'},
  ];

  void _saveEmotion(BuildContext context) async {
    final content = _noteController.text.trim();

    if (selectedEmotion == null) {
      DialogService.showError(context, 'Lỗi', 'Vui lòng chọn cảm xúc của bạn.');
      return;
    }

    if (content.isEmpty) {
      DialogService.showError(context, 'Lỗi', 'Vui lòng nhập ghi chú cảm xúc.');
      return;
    }

    try {
      setState(() {
        _isLoading = true;
      });
      await EmotionService.addEmotion(
        content: content,
        typeEmotion: selectedEmotion!,
      );

      _noteController.clear();
      setState(() => selectedEmotion = null);

      if (context.mounted) {
        DialogService.showSuccess(
          context,
          'Thành công',
          'Đã lưu cảm xúc thành công!',
        );
      }
    } catch (e) {
      if (context.mounted) {
        DialogService.showError(context, 'Lỗi', 'Lỗi khi lưu cảm xúc: $e');
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
        borderRadius: radius12,
        color: Colors.white,
      ),
      child: Column(
        spacing: Gap.md,
        children: [
          Text(
            'Hôm nay bạn cảm thấy thế nào?',
            style: context.textTheme.bodyMedium,
          ),
          Row(
            spacing: Gap.md,
            children: emotions.take(3).map((e) {
              final isSelected = selectedEmotion == e['type'];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedEmotion = e['type']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withAlpha(77)
                          : Colors.transparent,
                      borderRadius: radius12,
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: SvgPicture.asset(e['asset']!),
                  ),
                ),
              );
            }).toList(),
          ),

          Row(
            spacing: Gap.md,
            children: emotions.skip(3).map((e) {
              final isSelected = selectedEmotion == e['type'];
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedEmotion = e['type']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withAlpha(77)
                          : Colors.transparent,
                      borderRadius: radius12,
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: SvgPicture.asset(e['asset']!),
                  ),
                ),
              );
            }).toList(),
          ),

          // Ô nhập ghi chú
          TextFieldApp(
            controller: _noteController,
            hintText: 'Viết ghi chú về cảm xúc của bạn...',
            maxLines: 3,
            fillColor: const Color.fromARGB(20, 0, 0, 0),
          ),

          // Nút lưu
          ButtonApp(
            onPressed: () {
              _saveEmotion(context);
            },
            icon: _isLoading ? SizedBox.shrink() : const Icon(Icons.add),
            borderRadius: radius12,
            child: _isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('Lưu ghi chú'),
          ),
        ],
      ),
    );
  }
}
