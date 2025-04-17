
import 'package:flutter/material.dart';

import '../../../../core/model/log_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/typography.dart';


class LogListItem extends StatelessWidget {

  const LogListItem({
    required this.logModel
  });

  final LogModel logModel;

  Widget? getTitleByType(String type, BuildContext context) {
    switch(type) {
      case 'Debug': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black100,
        ),
      );
      case 'Info': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black100,
        ),
      );
      case 'Warning': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black100,
        ),
      );
      case 'Error': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black100,
        ),
      );
      case 'Fatal': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black100,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTitleByType(logModel.type, context) ?? const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                logModel.name,
                style: AppTypography.font14Regular.copyWith(
                  color: AppColors.black100,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                logModel.details.toString(),
                style: AppTypography.font14Regular.copyWith(
                  color: AppColors.black100,
                ),
                overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    );
  }
}