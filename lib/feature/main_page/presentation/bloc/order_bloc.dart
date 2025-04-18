import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:vas_ods/core/enum/application_status.dart';
import 'package:vas_ods/core/utils/shared_preference.dart';
import 'package:vas_ods/feature/main_page/domain/entities/order_service_entitie.dart';

import '../../../../main.dart';
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

      if (data != null) {
        orderCubit.groupByDocumentId(data.data);
        print(data.data);

        // Подсчитываем количество заявок со статусом "in work"
        final inWorkCount = data.data.where((item) => item.status == 'in work').length;

        emit(state.copyWith(
          getApplicationsResponse: data,
          applicationCount: data.data.length,
          applicationInWorkCount: inWorkCount, // Ставим количество заявок со статусом "in work"
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
