import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:vas_ods/core/enum/application_status.dart';
import 'package:vas_ods/core/model/grouped_orders_stats.dart';
import 'package:vas_ods/core/utils/shared_preference.dart';
import 'package:vas_ods/feature/main_page/domain/entities/order_service_entitie.dart';

import '../../../../main.dart';
import '../../data/models/order_service_model.dart';
import '../../domain/usecases/order_usecase.dart';
import '../cubit/order_cubit.dart';

part 'order_event.dart';

part 'order_state.dart';

@lazySingleton
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderUseCase orderUseCase;
  final OrderCubit orderCubit;

  OrderBloc({required this.orderUseCase, required this.orderCubit}) : super(OrderInitial()) {
    on<GetApplicationsByDateEvent>(_onGetApplicationsByDateEvent);
    on<ChangeDateEvent>(_onChangeDateEvent);
    on<GetAllApplicationsEvent>(_onGetAllApplicationsEvent);
    on<ChangeApplicationStatusEvent>(_onChangeApplicationStatusEvent); // ✅ Добавлено
  }

  SharedPrefsRawProvider sharedPrefsRawProvider = SharedPrefsRawProvider(prefs);

  Future<void> _onGetApplicationsByDateEvent(GetApplicationsByDateEvent event, Emitter<OrderState> emit) async {
    final userId = sharedPrefsRawProvider.getInt(SharedKeyWords.userId);
    final token = sharedPrefsRawProvider.getString(SharedKeyWords.accessTokenKey);

    try {
      final data = await orderUseCase.getApplicationsByDate(
        userId: userId?.toInt() ?? 0,
        token: token ?? '',
        date: event.date,
      );

      if (data != null && data.data !=null) {
        orderCubit.groupByDocumentId(data.data!);
        print(data.data);

        // Подсчитываем количество заявок со статусом "in work"
        final inWorkCount = data.data!.where((item) => item.status == 'in work').length;

        emit(state.copyWith(
          getApplicationsResponse: data,
          applicationCount: data.data!.length,
          applicationInWorkCount: inWorkCount, // Ставим количество заявок со статусом "in work"
        ));
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _onGetAllApplicationsEvent(GetAllApplicationsEvent event, Emitter<OrderState> emit) async {
    final userId = sharedPrefsRawProvider.getInt(SharedKeyWords.userId);
    final token = sharedPrefsRawProvider.getString(SharedKeyWords.accessTokenKey);

    try {
      final data = await orderUseCase.getApplicationsByDate(
        userId: userId ?? 0,
        token: token ?? '',
        date: '1970-01-01',
      );

      if (data != null && data.data != null) {
        final List<OrderServiceItem> items = data.data!;

        // Группировка по дате
        final Map<String, List<OrderServiceItem>> groupedByDate = {};

        for (final item in items) {
          final createdAtString = item.createdAt;
          if (createdAtString == null || createdAtString.isEmpty) continue;

          // Преобразуем строку в DateTime и форматируем как yyyy-MM-dd
          final createdAt = DateTime.tryParse(createdAtString);
          if (createdAt == null) continue;

          final formattedDate = DateFormat('yyyy-MM-dd').format(createdAt);
          groupedByDate.putIfAbsent(formattedDate, () => []);
          groupedByDate[formattedDate]!.add(item);
        }

        // Строим статистику по каждой дате
        final List<GroupedOrderStats> groupedStats = [];

        for (var entry in groupedByDate.entries) {
          final date = entry.key;
          final orders = entry.value;

          if (!orders.any((item) => item.status == 'in work')) continue;

          groupedStats.add(GroupedOrderStats(
            date: date,
            readyCount: orders.where((e) => e.status == 'ready').length,
            inWorkCount: orders.where((e) => e.status == 'in work').length,
            cancelledCount: orders.where((e) => e.status == 'cancelled').length,
            errorCount: orders.where((e) => e.status == 'error').length,
            completedCount: orders.where((e) => e.status == 'completed').length,
          ));
        }

        // Логгируем подробности
        for (final group in groupedStats) {
          print(group.toString());
        }

        // Сохраняем сгруппированную статистику
        orderCubit.groupedStats(groupedStats);

        // Общее количество "in work"
        final inWorkCount = items.where((item) => item.status == 'in work').length;

        emit(state.copyWith(
          getApplicationsResponse: data,
          // applicationCount: items.length,
          // applicationInWorkCount: inWorkCount,
        ));
      }
    } catch (e) {
      rethrow;
    }
  }






  /// Обработка обновления статуса заявки
  Future<void> _onChangeApplicationStatusEvent(ChangeApplicationStatusEvent event, Emitter<OrderState> emit) async {
    try {
      await orderUseCase.updateApplication(
        userId: event.userId,
        token: event.token,
        applicationId: event.applicationId,
        status: event.status,
        description: event.description,
      );
      emit(state.copyWith(applicationStatus: ApplicationStatus.success));
      emit(state.copyWith(applicationStatus: ApplicationStatus.initial));
    } catch (e) {
      debugPrint('Ошибка при обновлении статуса: $e');
      // emit(OrderStatusChangeFailed()); // если нужно отдельное состояние для ошибки
    }
  }

  Future<void> _onChangeDateEvent(ChangeDateEvent event, Emitter<OrderState> emit) async {
    print('event : ${event.date}');
    emit(state.copyWith(
      selectedDate: event.date,
      selectedDateFormatted: DateFormat('yyyy-MM-dd').format(event.date),
    ));
  }
}
