import 'package:injectable/injectable.dart';
import 'package:vas_ods/feature/main_page/data/api/service/order_service_api.dart';
import 'package:vas_ods/feature/main_page/domain/entities/order_service_entitie.dart';
import 'package:vas_ods/feature/main_page/domain/repository/order_repository.dart';

@LazySingleton(as: OrderRepository)
class OrderRepositoryImpl extends OrderRepository {
  OrderRepositoryImpl({required this.orderServiceApi});

  final OrderApiDioService orderServiceApi;

  @override
  Future<OrderServiceEntity?> getApplicationsByDate({
    required int userId,
    required String token,
    required String date,
  }) async {
    try {
      final model = await orderServiceApi.getApplicationsByDate(
        userId: userId,
        token: token,
        date: date,
      );

      if (model == null) return null;

      return OrderServiceEntity(
        code: model.code,
        data: model.data,
      );
    } catch (e) {
      throw Exception('Ошибка при получении заявок по дате: $e');
    }
  }

  @override
  Future<void> updateApplication({
    required int userId,
    required String token,
    required int applicationId,
    required String status,
    String? description,
  }) async {
    try {
      await orderServiceApi.updateApplication(
        userId: userId,
        token: token,
        applicationId: applicationId,
        status: status,
        description: description,
      );
    } catch (e) {
      throw Exception('Ошибка при обновлении заявки: $e');
    }
  }
}
