import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/common/widgets/button_app.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/presentation/authentication/login_page.dart';
import 'package:quit_smoking/presentation/intro/widgets/indicator.dart';

class Intro1Page extends StatefulWidget {
  const Intro1Page({super.key});

  @override
  State<Intro1Page> createState() => _Intro1PageState();
}

class _Intro1PageState extends State<Intro1Page> {
  int index = 0;

  final List<String> icon = [
    'assets/images/heart.svg',
    'assets/images/chart.svg',
    'assets/images/community.svg',
  ];

  final List<String> title = [
    'Chăm sóc sức khỏe',
    'Tiết kiệm tiền bạc',
    'Cộng đồng hỗ trợ',
  ];

  final List<String> subtitle = [
    'Theo dõi sự cải thiện của phổi, tim và năng\nlượng cơ thể sau khi bỏ thuốc lá',
    'Xem số tiền bạn tiết kiệm được mỗi ngày khi\nkhông mua thuốc lá',
    'Kết nối với những người chí hướng, chia \nsẻ và động viên lẫn nhau',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: paddingApp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Bỏ qua',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: shadowColor,
                      ),
                    ),
                  ),
                ],
              ),

              Spacer(),
              SvgPicture.asset(icon[index]),
              Gap.lgHeight,
              Text(title[index], style: context.textTheme.bodyLarge),
              Gap.lgHeight,
              Text(
                subtitle[index],
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                  color: secondaryColor,
                  fontSize: 13,
                ),
              ),
              Gap.xxlHeight,
              Indicator(index),
              Spacer(),
              ButtonApp(
                onPressed: () {
                  if (index == 2) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    return;
                  }
                  setState(() {
                    index++;
                  });
                },
                icon: Icon(Icons.arrow_forward_ios_rounded, size: Gap.md),
                child: Text(index == 2 ? 'Bắt đầu' : 'Tiếp theo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
