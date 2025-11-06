import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/formatter.dart';
import 'package:quit_smoking/configs/gap.dart';
import 'package:quit_smoking/models/app_user.dart';
import 'package:quit_smoking/presentation/home/widgets/welcome_home.dart';

class SummaryHome extends StatelessWidget {
  const SummaryHome(this.user, {super.key});

  final AppUser? user;

  caculatorPrice() {
    if (user == null) return 0;
    final daysSinceQuit = Formatter.getDaysSinceQuit(
      user?.quitStartDate ?? DateTime.now(),
    );
    return daysSinceQuit *
        user!.cigarettesPerDay /
        user!.cigarettesPerPack *
        user!.packPrice;
  }

  @override
  Widget build(BuildContext context) {
    final daysSinceQuit = Formatter.getDaysSinceQuit(
      user?.quitStartDate ?? DateTime.now(),
    );

    return Container(
      padding: EdgeInsets.all(Gap.mL),
      width: double.infinity,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          WelcomeHome(user),
          Gap.xlHeight,
          Container(
            padding: EdgeInsets.symmetric(vertical: Gap.md, horizontal: Gap.mL),
            decoration: BoxDecoration(
              borderRadius: radius25,
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: Gap.sm,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/images/calendar_day.svg'),
                      Text(
                        '$daysSinceQuit ngày',
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        'Ngày không hút',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: greyColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: Gap.sm,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/images/pig_money.svg'),
                      Text(
                        Formatter.formatCurrency(caculatorPrice()),
                        style: context.textTheme.bodyMedium,
                      ),
                      Text(
                        'Tiền tiết kiệm',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: greyColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    spacing: Gap.sm,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset('assets/images/fluent_reward.svg'),
                      Text('145 điểm', style: context.textTheme.bodyMedium),
                      Text(
                        'Điểm thưởng',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: greyColor,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
