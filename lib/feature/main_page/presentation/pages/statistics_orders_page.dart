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
                _buildHeader('Ожидают выполнения'),
                const VerticalDividerWidget(),
                _buildHeader('Выполнены'),
                const VerticalDividerWidget(),
                _buildHeader('Получены заказчиком'),
                const VerticalDividerWidget(),
                _buildHeader('Отмечены ошибкой'),
                const VerticalDividerWidget(),
                _buildHeader('Отменены заказчиком'),
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
                    final isLastRow = index == stats.length - 1;

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border(
                          left: const BorderSide(color: AppColors.white, width: 1),
                          right: const BorderSide(color: AppColors.white, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildCell(item.date, drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.inWorkCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.readyCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.completedCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.errorCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.cancelledCount}', drawTopBorder: true, drawBottomBorder: isLastRow, isLastColumn: true),
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

  Widget _buildCell(
      String text, {
        bool isLastColumn = false,
        bool drawTopBorder = false,
        bool drawBottomBorder = false,
      }) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: drawTopBorder ? const BorderSide(color: AppColors.white, width: 1) : BorderSide.none,
            bottom: drawBottomBorder ? const BorderSide(color: AppColors.white, width: 1) : BorderSide.none,
            right: isLastColumn ? BorderSide.none : const BorderSide(color: AppColors.white, width: 1),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTypography.font16Regular.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
