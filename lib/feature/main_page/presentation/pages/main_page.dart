import 'package:flutter/material.dart';
import 'package:vas_ods/core/theme/app_colors.dart' show AppColors;
import 'package:vas_ods/core/widgets/app_bar_widget.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart' show AppRoute;


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String name = AppRoute.mainScreenPath;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black50,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BreakfastAppBarWidget(
                selectTime: TimeOfDay.fromDateTime(DateTime.now()),
              ),
              // if (state is BreakfastLoading && state.isInitial == true)
              //   const Expanded(
              //     child: Center(
              //       child: CircularProgressIndicator(),
              //     ),
              //   ),
              // Expanded(
              //     child: ListView.separated(
              //       controller: _scrollController,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: keys.length,
              //       itemBuilder: (context, index) {
              //         final timeSlot = keys[index];
              //         final orders = groupedOrders[timeSlot];
              //
              //         return LargeBreakfastWidget(
              //           selectTime: state.selectTime,
              //           time: timeSlot,
              //           cardCount: orders?.length ?? 0,
              //           groupOrdersList: orders ?? [],
              //           selectDate: state.selectDate,
              //         );
              //       },
              //       separatorBuilder: (BuildContext context, int index) {
              //         return const VerticalDivider(
              //           thickness: 1,
              //           color: AppColors.gray400,
              //         );
              //       },
              //     ))
            ],
          ),
          // Positioned(
          //   right: 16,
          //   bottom: 16,
          //   child: SmallInfoWidget(
          //     breakfastCount: cubitState.ordersSummary?.breakfastsCount ?? 0,
          //     breakfastSelected: cubitState.ordersSummary?.breakfastsSelected ?? 0,
          //     breakfastAssepted: cubitState.ordersSummary?.breakfastsAssepted ?? 0,
          //     breakfastNoSelected: cubitState.ordersSummary?.breakfastsNotSelected ?? 0,
          //     // breakfastAssepted: 3
          //   ),
          // ),
        ],
      ),
    );
  }}
