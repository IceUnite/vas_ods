import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:vas_ods/feature/main_page/data/models/order_service_model.dart';

import '../../../../core/enum/card_status.dart';
import '../../../../core/model/grouped_orders_stats.dart';
import '../../../../core/theme/app_colors.dart';

part 'order_state.dart';

@lazySingleton
class OrderCubit extends Cubit<OrderCubitState> {
  OrderCubit()
      : super(OrderCubitState(
            groupedApplicationList: [],
            selectedDate: DateTime.now(),
            selectedDateFormatted: DateFormat('yyyy-MM-dd').format(DateTime.now()),
            groupedStats: []));

  List<List<OrderServiceItem?>?> groupByDocumentId(List<OrderServiceItem> items) {
    final Map<int, List<OrderServiceItem>> grouped = {};

    // Задаем приоритеты статусов
    const statusOrder = ["in work", "error", "ready", "completed", "cancelled"];
    final statusPriority = {for (var i = 0; i < statusOrder.length; i++) statusOrder[i]: i};

    // Группировка по idDoc
    for (final item in items) {
      final docId = item.idDoc;

      if (!grouped.containsKey(docId)) {
        grouped[docId ?? 0] = [];
      }
      grouped[docId]!.add(item);
    }

    /// Сортировка внутри каждой группы по статусу в таком порядке
    /// ["in work", "error", "ready", "completed", "cancelled"].
    final sortedGroupedList = grouped.values.map((group) {
      group.sort((a, b) {
        final aPriority = statusPriority[a.status] ?? statusOrder.length;
        final bPriority = statusPriority[b.status] ?? statusOrder.length;
        return aPriority.compareTo(bPriority);
      });
      return group;
    }).toList();

    emit(OrderCubitState(
        groupedApplicationList: sortedGroupedList,
        selectedDate: state.selectedDate,
        selectedDateFormatted: state.selectedDateFormatted,
        groupedStats: state.groupedStats));
    return sortedGroupedList;
  }

  void updateSelectedDate(DateTime newDate) {
    emit(OrderCubitState(
      groupedApplicationList: state.groupedApplicationList,
      selectedDate: newDate,
      selectedDateFormatted: DateFormat('yyyy-MM-dd').format(newDate),
      groupedStats: state.groupedStats,
    ));
  }

  static StatusUIConfig getStatusUIConfig(String? status) {
    switch (status) {
      case 'in work':
        return const StatusUIConfig(
          appBarColor: AppColors.blue,
          buttonColor: AppColors.blue,
          buttonText: 'Выполнить',
        );
      case 'ready':
        return const StatusUIConfig(
          appBarColor: AppColors.green,
          buttonColor: AppColors.greenLight,
          buttonText: 'Выполнен',
        );
      case 'completed':
        return const StatusUIConfig(
          appBarColor: AppColors.greenLight,
          buttonColor: AppColors.greenLight,
          buttonText: 'Получен',
        );
      case 'cancelled':
        return const StatusUIConfig(
          appBarColor: AppColors.redLight,
          buttonColor: AppColors.redLight,
          buttonText: 'Отменен',
        );
      case 'error':
        return const StatusUIConfig(
          appBarColor: AppColors.red,
          buttonColor: AppColors.redLight,
          buttonText: 'Ошибка',
        );
      default:
        return const StatusUIConfig(
          appBarColor: AppColors.blue,
          buttonColor: AppColors.blue,
          buttonText: 'Выполнить',
        );
    }
  }

  static String formatStatusDate(String rawDate, String status) {
    try {
      final date = DateTime.parse(rawDate);
      final formattedDate = DateFormat('dd/MM/yy').format(date);
      final formattedTime = DateFormat('HH:mm').format(date);

      final statusText = {
            'ready': 'Документ готов',
            'in work': 'Заявка поступила',
            'cancelled': 'Заказ отменён',
            'error': 'Отмечена ошибка',
            'completed': 'Документ получен',
          }[status.toLowerCase()] ??
          'Дата обновления';

      return '$statusText: $formattedDate \n в $formattedTime';
    } catch (e) {
      return rawDate;
    }
  }

  ///Преобразует формат даты
  static String formatDate(String rawDate) {
    final dateTime = DateTime.parse(rawDate);
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }

  void groupedStats(List<GroupedOrderStats> data) {
    emit(OrderCubitState(
        groupedApplicationList: state.groupedApplicationList,
        selectedDate: state.selectedDate,
        selectedDateFormatted: state.selectedDateFormatted,
        groupedStats: data));
  }
}
