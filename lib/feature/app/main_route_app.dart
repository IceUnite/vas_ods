
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:vas_ods/feature/app/init_screen.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart' show AppRoute;
import 'package:vas_ods/feature/auth_page/presentation/pages/auth_page.dart';
import 'package:vas_ods/feature/main_page/presentation/pages/main_page.dart';


class LoggerNavigationObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    debugPrint(':::didPush $route $previousRoute');
  }
}


final rootNavigatorKey = GlobalKey<NavigatorState>();
final goRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoute.init,
  observers: <NavigatorObserver>[LoggerNavigationObserver()],
  routes: [
    GoRoute(
        path: AppRoute.init,
        name: AppRoute.init,
        builder: (context, state) {
          return  const InitScreen();
        },
        routes: [
          GoRoute(
            path: AppRoute.authScreenPath,
            name: AppRoute.authScreenPath,
            pageBuilder: (context, state) {
              return const NoTransitionPage(
                child: AuthPage(),
              );
            },
          ),
          GoRoute(
            path: AppRoute.mainScreenPath,
            name: AppRoute.mainScreenPath,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: MainPage(),
            ),
          ),
          // GoRoute(
          //   path: AppRoute.debugMenuPath,
          //   name: AppRoute.debugMenuPath,
          //   pageBuilder: (context, state) => NoTransitionPage(
          //     child: DebugMenu(),
          //   ),
          // ),
          // GoRoute(
          //   path: AppRoute.selectServerPath,
          //   name: AppRoute.selectServerPath,
          //   pageBuilder: (context, state) => NoTransitionPage(
          //     child: SelectServerMenu(
          //       onSelect: (ServerType type) async {
          //         await prefs.remove('isUserAuth');
          //       },
          //     ),
          //   ),
          // ),
        ]),
  ],
  errorBuilder: ((context, state) => Container()),
);
