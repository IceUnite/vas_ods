import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/app_colors.dart';
import 'package:vas_ods/core/theme/typography.dart';
import 'package:vas_ods/core/widgets/app_bar_widget.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart';

import '../../../../core/widgets/vertical_divider_widget.dart';

class StatisticsOrdersPage extends StatelessWidget {
  const StatisticsOrdersPage({Key? key}) : super(key: key);
  static String name = AppRoute.statisticsScreenPath;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BreakfastAppBarWidget(
            selectTime: TimeOfDay.fromDateTime(DateTime.now()),
          ),
         Row(
           children: [
             Spacer(),
             Text('Дата : ', style: AppTypography.font16Regular.copyWith(color: AppColors.orange),),
             Spacer(),
             const VerticalDividerWidget(),
             Spacer(),
             Spacer(),
             Text('Дата : ', style: AppTypography.font16Regular.copyWith(color: AppColors.orange),),
             Spacer(),
             const VerticalDividerWidget(),
             Spacer(),
             Spacer(),
             Text('Дата : ', style: AppTypography.font16Regular.copyWith(color: AppColors.orange),),
             Spacer(),
             const VerticalDividerWidget(),
             Spacer(),
             Spacer(),
             Text('Дата : ', style: AppTypography.font16Regular.copyWith(color: AppColors.orange),),
             Spacer(),
             const VerticalDividerWidget(),
             Spacer(),
             Spacer(),
             Text('Дата : ', style: AppTypography.font16Regular.copyWith(color: AppColors.orange),),
             Spacer(),
             const VerticalDividerWidget(),
             Spacer(),
             Spacer(),
             Text('Дата : ', style: AppTypography.font16Regular.copyWith(color: AppColors.orange),),
             Spacer(),
             const VerticalDividerWidget(),
             Spacer(),

           ],
         )

        ],
      ),
    );
  }
}

