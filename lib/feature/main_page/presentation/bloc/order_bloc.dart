import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:vas_ods/core/utils/shared_preference.dart';

import '../../../../main.dart';
import '../../domain/usecases/order_usecase.dart';

part 'order_event.dart';

part 'order_state.dart';

@lazySingleton
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderUseCase orderUseCase;

  OrderBloc({required this.orderUseCase}) : super(OrderInitial()) {
    on<GetApplicationsByDateEvent>(_onGetApplicationsByDateEvent);
  }

  SharedPrefsRawProvider sharedPrefsRawProvider = SharedPrefsRawProvider(prefs);

  // final ProfileUseCase luggageUseCase;

  Future<void> _onGetApplicationsByDateEvent(GetApplicationsByDateEvent event, Emitter<OrderState> emit) async {
    final userId = sharedPrefsRawProvider.getInt(SharedKeyWords.userId);
    final token = sharedPrefsRawProvider.getString(SharedKeyWords.accessTokenKey);
    try {
      print('userId: $userId');
      print('token: $token');
      print('data: 2025-02-12');
      final data = await orderUseCase.getApplicationsByDate(
        userId: userId?.toInt() ?? 0,
        token: token ?? '',
        date: '2025-02-12',
      );
      print('data: $data'); print('data: $data');
    } catch (e) {
     print('errrrrrrrrrr');
      rethrow;
    }

  }
}
