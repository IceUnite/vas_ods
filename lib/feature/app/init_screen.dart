import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vas_ods/core/theme/app_colors.dart';
import 'package:vas_ods/feature/auth_page/presentation/bloc/auth_bloc.dart' show AuthBloc, AuthFailure, AuthSuccess, AuthUnauthorized, CheckTokenEvent;

import 'routing/route_path.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String name = AppRoute.init;

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    final token = prefs.getString('accessToken');

    if (userId != null && token != null) {
      // Вызов события для проверки токена
      context.read<AuthBloc>().add(CheckTokenEvent(userId: userId, token: token));

      // Подписываемся на изменения состояния блока
      context.read<AuthBloc>().stream.listen((state) {
        if (state is AuthSuccess) {
          // Если токен валидный, переходим на основной экран
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed(AppRoute.mainScreenPath);
          });
        } else if (state is AuthUnauthorized || state is AuthFailure) {
          // Если не авторизован, переходим на экран авторизации
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.goNamed(AppRoute.authScreenPath);
          });
        }
      });
    } else {
      // Если нет токена или userId, сразу переходим на экран авторизации
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed(AppRoute.authScreenPath);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SizedBox(
        // width: 150,
        // height: 140,
        // child: SvgPicture.asset(
        //   VectorAssets.logoWhite,
        // ),
      ),
    );
  }
}
