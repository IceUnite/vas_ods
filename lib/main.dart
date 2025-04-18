import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vas_ods/core/internal/di/sl.dart';
import 'package:vas_ods/feature/app/app.dart';

import 'feature/auth_page/presentation/bloc/auth_bloc.dart';



late SharedPreferences prefs;

Future<void> main() async {
  // ‼️пиздец без инициализации префсов все нахуй падает ибо их нет в гетите
  // ‼️проебано 3 часа времени 10/02/25

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  prefs = await SharedPreferences.getInstance();
  configureDependencies();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(
    // Оборачиваем наше приложение в DevicePreview
    DevicePreview(
      enabled: false, // Включаем только в режиме разработки
      builder: (context) => const Application(),
    ),
  );
}

class Listeners extends StatefulWidget {
  final Widget child;

  const Listeners({required this.child, super.key});

  @override
  State<Listeners> createState() => _ListenersState();
}

class _ListenersState extends State<Listeners> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: const [
          BlocListener<AuthBloc, AuthState>(
            listener: _authorizationHandler,
          ),
        ],
        child: widget.child
    );
  }
}
void _authorizationHandler(BuildContext context, AuthState state) {
  // if (state is AuthorizationLoginState) {
  //   context.goNamed(AppRoute.breakfastScreenPath);
  // } else {
  //   context.goNamed(AppRoute.authScreenPath);
  // }
}