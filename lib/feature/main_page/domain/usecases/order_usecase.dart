import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vas_ods/core/errors/error_handler.dart';
import 'package:vas_ods/core/errors/exception.dart';
import 'package:vas_ods/feature/main_page/domain/entities/order_service_entitie.dart';

import '../repository/order_repository.dart';

@lazySingleton
class OrderUseCase {
  final OrderRepository orderRepository;

  const OrderUseCase({required this.orderRepository});

  /// Получение заявок по дате
  Future<OrderServiceEntity?> getApplicationsByDate({
    required int userId,
    required String token,
    required String date,
  }) async {
    try {
      final data = await orderRepository.getApplicationsByDate(
        userId: userId,
        token: token,
        date: date,
      );

      if (data == null) return null;

      return OrderServiceEntity(
        code: data.code,
        data: data.data,
      );
    } on DioException catch (e) {
      final exception = ServerException(e.message.toString());
      final failure = ErrorHandler.handleException(exception);
      throw failure;
    }
  }
}
