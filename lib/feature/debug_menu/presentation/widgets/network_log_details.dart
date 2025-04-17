
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vas_ods/feature/debug_menu/presentation/widgets/request_log_details.dart';
import 'package:vas_ods/feature/debug_menu/presentation/widgets/response_log_details.dart';

import '../../../../core/model/network_log_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/typography.dart';

class NetworkLogDetails extends StatefulWidget {
  const NetworkLogDetails({required this.networkLogModel});

  final NetworkLogModel networkLogModel;

  @override
  State<NetworkLogDetails> createState() => _NetworkLogDetailsState();
}

class _NetworkLogDetailsState extends State<NetworkLogDetails> with TickerProviderStateMixin {
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
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: AppColors.black100,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: AppColors.orange,
            tabs: <Widget>[
              Tab(
                icon: Text(
                  'Request',
                  style: AppTypography.font16Regular.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'Response',
                  style: AppTypography.font16Regular.copyWith(
                    fontWeight: FontWeight.w700,
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
            RequestLogDetails(networkLogModel: widget.networkLogModel),
            ResponseLogDetails(networkLogModel: widget.networkLogModel),
          ],
        ));
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
}
