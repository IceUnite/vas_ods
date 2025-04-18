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
import 'package:vas_ods/feature/main_page/presentation/bloc/order_bloc.dart';

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

  @override
  void initState() {
    super.initState();
    _formattedTime = _formatDateTime(DateTime.now());
    var state = context.read<OrderBloc>().state;
    context.read<OrderBloc>().add(GetApplicationsByDateEvent(date: state.selectedDateFormatted ?? ''));
    _timer = Timer.periodic(const Duration(seconds: 60), (Timer t) {
      setState(() {
        state = context.read<OrderBloc>().state;
        context.read<OrderBloc>().add(GetApplicationsByDateEvent(date: state.selectedDateFormatted ?? ''));
        _formattedTime = _formatDateTime(DateTime.now());
      });
    });
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).location;

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Container(
          height: 85,
          color: AppColors.black100,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: _handleLogoTap,
                child: SvgPicture.asset(
                  VectorAssets.logoWhite,
                  width: 50,
                  height: 50,
                ),
              ),
              const Spacer(),

              IconButton(
                  onPressed: () {
                    context.read<OrderBloc>().add(GetApplicationsByDateEvent(date: state.selectedDateFormatted ?? ''));
                  },
                  icon: SvgPicture.asset(
                    VectorAssets.refresh,
                    color: AppColors.white,
                    width: 30,
                    height: 30,
                  )),
              const VerticalDividerWidget(),
              IconButton(
                  onPressed: () {
                    context.goNamed(AppRoute.mainScreenPath);
                  },
                  icon: SvgPicture.asset(
                    VectorAssets.homeOutline,
                    color: currentLocation == '/${AppRoute.mainScreenPath}' ? AppColors.orange100 : AppColors.white,
                    width: 30,
                    height: 30,
                  )),
              const VerticalDividerWidget(),
              IconButton(
                  onPressed: () {
                    context.goNamed(AppRoute.statisticsScreenPath);
                  },
                  icon: SvgPicture.asset(
                    VectorAssets.calendarOutline,
                    color:
                        currentLocation == '/${AppRoute.statisticsScreenPath}' ? AppColors.orange100 : AppColors.white,
                    width: 30,
                    height: 30,
                  )),
              const VerticalDividerWidget(),
              const SizedBox(width: 12),
              const DataSelectorWidget(),
              const VerticalDividerWidget(),
              InkWell(
                onTap: () {
                  // handle time select
                },
                child: Text(
                  _formattedTime,
                  style: AppTypography.font32Regular.copyWith(color: AppColors.orange100),
                ),
              ),
              const VerticalDividerWidget(),
              IconButton(
                onPressed: () {
                  ApeironSpaceDialog.showActionDialog(
                    context,
                    title: "Вы уверены что хотите выйти из своего аккаунта?",
                    onPressedConfirm: () {},
                    confirmText: "Отмена",
                    closeText: 'Выйти',
                    onPressedClosed: () {
                      context.read<AuthBloc>().add(ExiteEvent());
                      context.goNamed(AppRoute.authScreenPath);
                    },
                  );
                },
                icon: SvgPicture.asset(
                  VectorAssets.exite,
                  width: 30,
                  height: 30,
                  color: AppColors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  int _logoTapCount = 0;
  Timer? _resetTapTimer;

  void _handleLogoTap() {
    _logoTapCount++;

    _resetTapTimer?.cancel();
    _resetTapTimer = Timer(const Duration(seconds: 2), () {
      _logoTapCount = 0;
    });

    if (_logoTapCount >= 5) {
      context.goNamed(AppRoute.debugMenuPath);
      _logoTapCount = 0;
      _resetTapTimer?.cancel();
    }
  }
}
