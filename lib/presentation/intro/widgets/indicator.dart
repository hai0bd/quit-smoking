import 'package:flutter/material.dart';
import 'package:quit_smoking/common/common.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/configs/gap.dart';

class Indicator extends StatelessWidget {
  const Indicator(this.index, {super.key});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: Gap.sm,
      children: [
        _buildIndex(index == 0),
        _buildIndex(index == 1),
        _buildIndex(index == 2),
      ],
    );
  }

  _buildIndex(bool isSelected) {
    return Container(
      width: isSelected ? Gap.lX : Gap.sm,
      height: Gap.sm,
      decoration: BoxDecoration(
        borderRadius: radius100,
        color: isSelected ? primaryColor : Color.fromARGB(255, 217, 217, 217),
      ),
    );
  }
}
