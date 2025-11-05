import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/common/extensions.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';

class ButtonApp extends StatelessWidget {
  const ButtonApp({
    super.key,
    this.borderRadius,
    required this.child,
    this.icon = const SizedBox.shrink(),
    this.height = 50,
    this.width = double.infinity,
    this.onPressed,
    this.backgroundColor,
  });

  final BorderRadius? borderRadius;
  final Widget child;
  final Widget icon;
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? radius100,
          color: backgroundColor ?? primaryColor,
        ),
        child: Row(
          spacing: Gap.sm,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_applyTextStyle(context, child), icon],
        ),
      ),
    );
  }

  _applyTextStyle(BuildContext context, Widget? child) {
    if (child == null) {
      return SizedBox.shrink();
    }
    if (child is Text) {
      return Text(child.data ?? '', style: context.textTheme.titleSmall);
    }
    return child;
  }
}
