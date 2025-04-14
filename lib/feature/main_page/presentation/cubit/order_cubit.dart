import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:vas_ods/feature/main_page/data/models/order_service_model.dart';

import '../../../../core/enum/card_status.dart';
import '../../../../core/theme/app_colors.dart';

part 'order_state.dart';

@lazySingleton
class OrderCubit extends Cubit<OrderCubitState> {
  OrderCubit() : super(OrderCubitState(groupedApplicationList: []));

  List<List<OrderServiceItem?>?> groupByDocumentId(List<OrderServiceItem> items) {
    final Map<int, List<OrderServiceItem>> grouped = {};

    for (final item in items) {
      final docId = item.idDoc;

      if (!grouped.containsKey(docId)) {
        grouped[docId] = [];
      }
      grouped[docId]!.add(item);
    }
    emit(OrderCubitState(groupedApplicationList: grouped.values.toList()));
    return grouped.values.toList();
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


///Преобразует формат даты
  static String formatDate(String rawDate) {
    final dateTime = DateTime.parse(rawDate);
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(dateTime);
  }
}
