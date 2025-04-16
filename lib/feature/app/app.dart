import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vas_ods/core/theme/theme_notifier.dart' show ThemeNotifier;
import 'package:vas_ods/feature/app/bloc_providers.dart' show buildListProviders;
import 'package:vas_ods/feature/app/main_route_app.dart';
import 'routing/app_router_provider.dart' show AppRouterProvider;

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late GetIt locator;

  @override
  void initState() {
    locator = GetIt.instance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MultiBlocProvider(
            providers: buildListProviders(locator: locator),
            child: MaterialApp.router(
              darkTheme: ThemeData.dark(),
              theme: themeNotifier.currentTheme,
              builder: BotToastInit(),
              title: 'VAS ODS',
              routerConfig: goRouter,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
              ],
              themeMode: ThemeMode.light,
            ),
          );
        },
      ),
    );
  }
}