import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/app_colors.dart' show AppColors;

class AppButtonStyle {
  const AppButtonStyle._();

  static final primaryStyleOrange = ButtonStyle(
    fixedSize: WidgetStateProperty.all(const Size(335, 40)),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    )),
    textStyle: WidgetStateProperty.all(const TextStyle(color: AppColors.white)),
    backgroundColor: WidgetStateProperty.all(AppColors.orange200),
    elevation: const WidgetStatePropertyAll(5),
  );
  static final primaryStyleWhite = ButtonStyle(
    fixedSize: WidgetStateProperty.all(const Size(335, 40)),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    )),
    textStyle: WidgetStateProperty.all(const TextStyle(color: AppColors.black)),
    elevation: const WidgetStatePropertyAll(5),
    backgroundColor: WidgetStateProperty.all(AppColors.white50),
  );


  static final primaryStyleGreenOpacity = ButtonStyle(
    fixedSize: WidgetStateProperty.all(const Size(335, 40)),
    shape: WidgetStateProperty.all(RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    )),
    textStyle: WidgetStateProperty.all(const TextStyle(color: AppColors.green)),
    backgroundColor: WidgetStateProperty.all(AppColors.green300),
  );
}
