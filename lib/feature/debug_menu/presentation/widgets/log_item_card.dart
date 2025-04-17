
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/typography.dart';


class LogItemCard extends StatelessWidget {

  const LogItemCard({
    required this.title,
    required this.details,
  });

  final String? title;
  final String? details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Card(
        color: AppColors.gray.shade50,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title ?? '',
                  style: AppTypography.font16Regular.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.black100,
                  ),
                ),
                SelectableText(
                  details ?? '',
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  style: AppTypography.font16Regular.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.black100,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}