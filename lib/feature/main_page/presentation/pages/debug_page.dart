import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vas_ods/core/widgets/app_bar_widget.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../app/routing/route_path.dart';
final Talker talker = TalkerFlutter.init();

class DebugPage extends StatelessWidget {
  const DebugPage({Key? key}) : super(key: key);
  static String name = AppRoute.debugScreenPath;

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouter.of(context).location;
    return    TalkerScreen(
      talker: talker,
      appBarLeading: IconButton(
        onPressed: () {
          context.goNamed(AppRoute.mainScreenPath);
        },
        icon: Icon(
          Icons.home_rounded,
          color: currentLocation == '/${AppRoute.mainScreenPath}'
              ? AppColors.orange100
              : AppColors.white,
          size: 30,
        ),
      )
    );
  }
}
