import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vas_ods/core/resources/assets/resources.dart' show VectorAssets;
import 'package:vas_ods/core/theme/app_colors.dart' show AppColors;
import 'package:vas_ods/core/theme/typography.dart' show AppTypography;
import 'package:vas_ods/core/widgets/data_selector_widget.dart';
import 'package:vas_ods/core/widgets/ods_alert.dart';
import 'package:vas_ods/core/widgets/vertical_divider_widget.dart' show VerticalDividerWidget;
import 'package:vas_ods/feature/app/routing/route_path.dart' show AppRoute;
import 'package:vas_ods/feature/auth_page/presentation/bloc/auth_bloc.dart';
import 'package:vas_ods/main.dart';

class BreakfastAppBarWidget extends StatefulWidget {
  const BreakfastAppBarWidget({Key? key, required this.selectTime}) : super(key: key);
  final TimeOfDay? selectTime;

  @override
  _BreakfastAppBarWidgetState createState() => _BreakfastAppBarWidgetState();
}

class _BreakfastAppBarWidgetState extends State<BreakfastAppBarWidget> {
  late Timer _timer;
  late Timer _timerTime;
  late String _formattedTime;
  TimeOfDay? _selectedTime;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _formattedTime = _formatDateTime(DateTime.now().toUtc());
    print('_formattedTime $_formattedTime');
    _timer = Timer.periodic(const Duration(minutes: 1), (Timer t) {
      if (_isChecked == true) {
        // _loadDeliverySlots();
        // _loadBreakfastOrders();
        // _loadBreakfastOrdersSummary();
      }
    });
    // _timerTime = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
    // _timerUpTime = Timer.periodic(const Duration(seconds: 1), (Timer t) => addOneMinute(_selectedTime));
  }

  String _formatDateTime(DateTime dateTime) {
    var formatter = DateFormat('HH:mm');
    return formatter.format(dateTime);
  }

  String formatTimeOfDay(TimeOfDay? timeOfDay) {
    final hours = timeOfDay?.hour.toString().padLeft(2, '0');
    final minutes = timeOfDay?.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  void dispose() {
    _timer.cancel();
    _timerTime.cancel();
    // _timerUpTime.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      color: AppColors.black100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                VectorAssets.logoWhite,
                width: 50,
                height: 50,
              )),
          SizedBox(
            width: 20,
          ),
          Text(
            'Военная академия связи имени маршала Советского союза С.М. Буденого',
            style: TextStyle(fontSize: 18, color: AppColors.orange100),
          ),
          const Spacer(),
          // Checkbox(
          //   value: _isChecked,
          //   onChanged: (newValue) {
          //     setState(() {
          //       _isChecked = newValue!;
          //     });
          //   },
          // ),
          DataSelectorWidget(),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: () {
              // _selectTime(
              //   context: context,
              // );
            },
            child: SizedBox(
              width: 100,
              child: Text(
                _formattedTime,
                style: AppTypography.font32Regular.copyWith(color: AppColors.orange100),
              ),
            ),
          ),
          const VerticalDividerWidget(),
          IconButton(
              onPressed: () {
                ApeironSpaceDialog.showActionDialog(context,
                    title: "Вы уверены что хотите выйти из своего аккаунта?", onPressedConfirm: () {

                    }, confirmText: "Отмена", closeText: 'Выйти', onPressedClosed: () { context.read<AuthBloc>().add(
                      ExiteEvent(),
                    );
                    context.goNamed(AppRoute.authScreenPath); });
              },
              icon: SvgPicture.asset(VectorAssets.exite, width: 30, height: 30, color: AppColors.white)),
          const SizedBox(
            width: 20,
          ),
        ],

      ),
    );
  }

// void _loadHotels() {
//   context.read<ProfileBloc>().add(const LoadHotelsEvent(hotelIds: [1]));
// }
//
// void _loadBreakfastOrders() {
//   final currentState = context.read<BreakfastBloc>().state;
//   final DateTime useDate = currentState.selectDate ?? DateTime.now();
//
//   final DateTime currentDateWithoutTime = DateTime(useDate.year, useDate.month, useDate.day);
//   final DateTime currentDateWithoutTimeNext =
//   DateTime(useDate.year, useDate.month, useDate.day).add(const Duration(days: 1));
//
//   context.read<BreakfastBloc>().add(LoadBreakfastOrdersEvent(
//       from: currentDateWithoutTime,
//       to: currentDateWithoutTimeNext,
//       hotelIds: [1],
//       statuses: [
//         'Paid',
//         'Completed',
//         'OnDelivery',
//         'Accepted',
//         'Closed',
//       ],
//       page: 0,
//       pageSize: 10,
//       isInitial: false));
// }
//
// void _updateTime() {
//   setState(() {
//     _formattedTime = formatTimeOfDay(widget.selectTime);
//     print('widget.selectTime ${widget.selectTime}');
//   });
// }
//
// TimeOfDay _convertToUtc(TimeOfDay timeOfDay) {
//   final now = DateTime.now();
//   final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
//   final utcDateTime = dateTime.toUtc();
//   return TimeOfDay(hour: utcDateTime.hour, minute: utcDateTime.minute);
// }
//
// Future<void> _selectTime({required BuildContext context}) async {
//   print('_selectedTime ${_selectedTime}');
//   print('_convertToUtc(TimeOfDay.now() ${_convertToUtc(TimeOfDay.now())}');
//   final TimeOfDay? picked = await showTimePicker(
//     context: context,
//     initialTime: _selectedTime ?? _convertToUtc(TimeOfDay.now()),
//   );
//   if (picked != null && picked != _selectedTime) {
//     _selectedTime = picked;
//     context.read<BreakfastBloc>().add(SetTimeEvent(selectTime: _selectedTime));
//     _updateTime();
//     setState(() {
//       _loadDeliverySlots();
//       _loadBreakfastOrders();
//       _loadBreakfastOrdersSummary();
//     });
//   }
// }
//
// void addOneMinute(TimeOfDay? time) {
//   int newHour = time!.hour;
//   int newMinute = time.minute + 1;
//
//   if (newMinute == 60) {
//     newMinute = 0;
//     newHour = (newHour + 1) % 24;
//   }
//   TimeOfDay newTime = TimeOfDay(hour: newHour, minute: newMinute);
//   context.read<BreakfastBloc>().add(SetTimeEvent(selectTime: newTime));
// }
//
// void _loadBreakfastOrdersSummary() {
//   final DateTime? from = context.read<BreakfastBloc>().state.selectDate;
//   final DateTime? to = context.read<BreakfastBloc>().state.selectDate?.add(const Duration(days: 1));
//   DateTime fromNoTime = sendDateWithoutTime(from!);
//   DateTime toNoTime = sendDateWithoutTime(to!);
//   final List<int> hotelIds = [1];
//
//   context.read<BreakfastBloc>().add(LoadBreakfastOrdersSummaryEvent(
//     from: fromNoTime,
//     to: toNoTime,
//     hotelIds: hotelIds,
//   ));
// }
//
// DateTime sendDateWithoutTime(DateTime dateTime) {
//   return DateTime(dateTime.year, dateTime.month, dateTime.day);
// }
//
// void _loadDeliverySlots() {
//   context.read<BreakfastBloc>().add(LoadDeliverySlotDTOEvent(
//     hotelId: 1,
//     date: context.read<BreakfastBloc>().state.selectDate,
//   ));
// }
//
// TimeOfDay getTimeOfDayFromUtc(DateTime dateTimeUtc) {
//   final utcTime = dateTimeUtc.toUtc();
//   return TimeOfDay(hour: utcTime.hour, minute: utcTime.minute);
// }
}
