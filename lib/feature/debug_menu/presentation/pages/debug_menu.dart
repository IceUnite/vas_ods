
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/typography.dart';
import '../../../app/routing/route_path.dart';
import 'logs.dart';
import 'network_logs.dart';

class DebugMenu extends StatefulWidget {
  const DebugMenu({super.key});

  @override
  State<DebugMenu> createState() => _MadInspectorViewState();
}

class _MadInspectorViewState extends State<DebugMenu> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
            size: 40,
          ),
          onPressed: () {
            context.goNamed(AppRoute.mainScreenPath);
          },
        ),
        backgroundColor: AppColors.black100,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: AppColors.white,
              size: 40,
            ),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.orange,
          tabs: <Widget>[
            Tab(
              icon: Text(
                "Log's",
                style: AppTypography.font16Regular.copyWith(
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
            ),
            Tab(
              icon: Text(
                'Network',
                style: AppTypography.font16Regular.copyWith(
                  fontSize: 16,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: Logs(),
          ),
          const Center(
            child: NetworkLogs(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
