import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vas_ods/core/theme/app_colors.dart';
import 'package:vas_ods/core/theme/typography.dart';
import 'package:vas_ods/core/widgets/app_bar_widget.dart';
import 'package:vas_ods/core/widgets/vertical_divider_widget.dart';
import 'package:vas_ods/feature/app/routing/route_path.dart';
import '../bloc/order_bloc.dart';
import '../cubit/order_cubit.dart';

class StatisticsOrdersPage extends StatefulWidget {
  const StatisticsOrdersPage({Key? key}) : super(key: key);
  static String name = AppRoute.statisticsScreenPath;

  @override
  State<StatisticsOrdersPage> createState() => _StatisticsOrdersPageState();
}

class _StatisticsOrdersPageState extends State<StatisticsOrdersPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetAllApplicationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BreakfastAppBarWidget(
            selectTime: TimeOfDay.fromDateTime(DateTime.now()),
            isActiveInitState: false,
          ),
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.black100,
              border: Border.all(
                color: AppColors.white,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                _buildHeader('Дата'),
                const VerticalDividerWidget(),
                _buildHeader('Ожидают выполнения'), // in work
                const VerticalDividerWidget(),
                _buildHeader('Выполнены'), // ready
                const VerticalDividerWidget(),
                _buildHeader('Получены заказчиком'), // completed
                const VerticalDividerWidget(),
                _buildHeader('Отмечены ошибкой'), // error
                const VerticalDividerWidget(),
                _buildHeader('Отменены заказчиком'), // cancelled
                const SizedBox(width: 20),
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                final stats = context.read<OrderCubit>().state.groupedStats;

                if (stats.isEmpty) {
                  return const Center(
                    child: Text(
                      'Нет данных',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: stats.length,
                  itemBuilder: (context, index) {
                    final item = stats[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          _buildCell(item.date),
                          _buildCell('${item.inWorkCount}'),
                          _buildCell('${item.readyCount}'),
                          _buildCell('${item.completedCount}'),
                          _buildCell('${item.errorCount}'),
                          _buildCell('${item.cancelledCount}'),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTypography.font16Regular.copyWith(
          color: AppColors.orange,
        ),
      ),
    );
  }

  Widget _buildCell(String text) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white, width: 1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTypography.font14Regular.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
