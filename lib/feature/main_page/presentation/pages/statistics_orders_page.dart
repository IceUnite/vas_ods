import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/app_colors.dart';
import 'package:vas_ods/core/widgets/app_bar_widget.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart';

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
          Spacer(),
          Center(child: Text('В разработке')),
          Spacer(),

        ],
      ),
    );
  }
}

