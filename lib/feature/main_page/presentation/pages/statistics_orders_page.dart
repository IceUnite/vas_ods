import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              color: AppColors.black100,
              border: Border.all(
                color: AppColors.gray.shade80,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 20),
                _buildHeader('Дата'),
                _VerticalDividerWidget(),
                _buildHeader('Ожидают выполнения'),
                _VerticalDividerWidget(),
                _buildHeader('Выполнены'),
                _VerticalDividerWidget(),
                _buildHeader('Получены заказчиком'),
                _VerticalDividerWidget(),
                _buildHeader('Отмечены ошибкой'),
                _VerticalDividerWidget(),
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

                    final itemDate = DateFormat('dd/MM/yyyy').parse(item.date);
                    final now = DateTime.now();

                    Color rowColor;
                    if (item.inWorkCount > 0) {
                      if (itemDate.isBefore(DateTime(now.year, now.month, now.day))) {
                        rowColor = Colors.red.withOpacity(0.2); // просрочено
                      } else {
                        rowColor = Colors.yellow.withOpacity(0.2); // в процессе
                      }
                    } else {
                      rowColor = Colors.green.withOpacity(0.2); // всё выполнено
                    }

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: rowColor,
                        border: Border(
                          left: BorderSide(color: AppColors.gray.shade80, width: 1),
                          right: BorderSide(color: AppColors.gray.shade80, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          _buildCell(item.date, drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.inWorkCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.readyCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.completedCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.errorCount}', drawTopBorder: true, drawBottomBorder: isLastRow),
                          _buildCell('${item.cancelledCount}',
                              drawTopBorder: true, drawBottomBorder: isLastRow, isLastColumn: true),
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

  Widget _VerticalDividerWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
      width: 1,
      height: 23,
      color: AppColors.gray.shade80,
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
            top: drawTopBorder ? BorderSide(color: AppColors.gray.shade80, width: 1) : BorderSide.none,
            bottom: drawBottomBorder ? BorderSide(color: AppColors.gray.shade80, width: 1) : BorderSide.none,
            right: isLastColumn ? BorderSide.none : BorderSide(color: AppColors.gray.shade80, width: 1),
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
