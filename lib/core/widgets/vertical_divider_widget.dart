import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/app_colors.dart' show AppColors;

class VerticalDividerWidget extends StatelessWidget {
  const VerticalDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
      width: 1,
      height: 23,
      color: AppColors.white,
    );
  }
}
