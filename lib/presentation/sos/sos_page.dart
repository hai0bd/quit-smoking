import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/services/sos_service.dart';

class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isCounting = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: false);

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _opacityAnimation = Tween<double>(
      begin: 0.4,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    if (_isCounting) return;

    setState(() {
      _remainingSeconds = 10;
      _isCounting = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() {
          _isCounting = false;
          _remainingSeconds = 0;
          SOSService.increaseCravingCount();
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  Widget _buildSOSButton() {
    final size = context.media.width / 3;
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.redAccent.withAlpha(
                    (_opacityAnimation.value * 255).toInt(),
                  ),
                ),
              ),
            );
          },
        ),

        // Nút chính
        GestureDetector(
          onTap: _startCountdown,
          child: Container(
            height: size,
            width: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 239, 68, 68),
              boxShadow: [
                BoxShadow(
                  color: Colors.redAccent,
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: Gap.sM,
              children: [
                SvgPicture.asset(
                  'assets/images/sos.svg',
                  width: 50,
                  height: 50,
                ),
                Text(
                  'SOS',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountdownCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Gap.md),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: appColor,
              borderRadius: radius12,
              border: Border.all(width: 1, color: borderColor),
            ),
            child: Column(
              spacing: Gap.md,
              children: [
                if (_isCounting) ...[
                  Text(
                    'Cơn thèm sẽ qua sau',
                    style: context.textTheme.bodyMedium,
                  ),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Hãy kiên trì! Bạn làm được!',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: textColor,
                    ),
                  ),
                ] else ...[
                  SvgPicture.asset('assets/images/cup.svg'),
                  Text(
                    '🎉 Chúc mừng bạn!',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Bạn đã vượt qua cơn thèm thành công',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ButtonApp(
                    onPressed: () {},
                    backgroundColor: Colors.white,
                    child: Text(
                      '✔ Hoàn Thành',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoItNow(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Gap.md),
      child: Column(
        spacing: Gap.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Làm ngay bây giờ', style: context.textTheme.titleSmall),
          _buildDoNowItem(
            context,
            'assets/images/wind.svg',
            'Hít thở sâu',
            'Hít vào 4 giây, giữ 4 giây, thở ra 4 giây',
          ),
          _buildDoNowItem(
            context,
            'assets/images/water.svg',
            'Uống nước',
            'Uống 1 cốc nước lạnh từ từ',
          ),
          _buildDoNowItem(
            context,
            'assets/images/chat.svg',
            'Nhắn tin bạn bè',
            'Chia sẻ với người thân để được động viên',
          ),
        ],
      ),
    );
  }

  _buildDoNowItem(
    BuildContext context,
    String icon,
    String title,
    String subTitle,
  ) {
    return Container(
      padding: EdgeInsets.all(Gap.md),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: borderColor),
        borderRadius: radius12,
      ),
      child: Row(
        spacing: Gap.sM,
        children: [
          SvgPicture.asset(icon),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: Gap.xs,
            children: [
              Text(
                title,
                style: context.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
              Text(
                subTitle,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 11,
                  color: textColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildWordsEncouragement(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Gap.sM),
      child: Column(
        spacing: Gap.md,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lời động viên', style: context.textTheme.titleSmall),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Gap.md),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: borderColor),
              borderRadius: radius12,
            ),
            child: Text(
              "Cơn thèm này sẽ chỉ kéo dài vài phút. Bạn mạnh mẽ hơn nó!",
              style: context.textTheme.bodySmall?.copyWith(color: textColor),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Gap.md),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: borderColor),
              borderRadius: radius12,
            ),
            child: Text(
              "Mỗi cơn thèm bạn vượt qua là một chiến thắng.\n",
              style: context.textTheme.bodySmall?.copyWith(color: textColor),
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(Gap.md),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: borderColor),
              borderRadius: radius12,
            ),
            child: Text(
              "Hãy nghĩ về lí do tại sao bạn quyết định bỏ thuốc.\n",
              style: context.textTheme.bodySmall?.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  _buildRedirectionActivity(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Gap.md),
      padding: EdgeInsets.all(Gap.md),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
        borderRadius: radius12,
        color: Color.fromARGB(255, 239, 246, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Gap.xs,
        children: [
          Text('Một chút lời khuyên', style: context.textTheme.titleSmall),
          Gap.xsHeight,
          Text(
            '• Đi bộ 5 - 10 phút',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: Color.fromARGB(255, 55, 65, 81),
            ),
          ),
          Text(
            '•  Nhai kẹo su không đường',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: Color.fromARGB(255, 55, 65, 81),
            ),
          ),
          Text(
            '• Chơi game 3 phút',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: Color.fromARGB(255, 55, 65, 81),
            ),
          ),
          Text(
            '• Nghe nhạc yêu thích',
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 11,
              color: Color.fromARGB(255, 55, 65, 81),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 249, 115, 22)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 249, 115, 22),
              ),
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nút SOS', style: context.textTheme.titleSmall),
                  Text(
                    'Đang có cơn thèm thuốc? Hãy thử những cách này!',
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Gap.xlHeight,
            _buildSOSButton(),
            Gap.lgHeight,
            _buildCountdownCard(),
            _buildDoItNow(context),
            _buildWordsEncouragement(context),
            _buildRedirectionActivity(context),
          ],
        ),
      ),
    );
  }
}
