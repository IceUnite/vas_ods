

import '../entities/order_service_entitie.dart';

abstract class OrderRepository {
  Future<OrderServiceEntity?> getApplicationsByDate({
    required int userId,
    required String token,
    required String date,
  });

  Future<void> updateApplication({
    required int userId,
    required String token,
    required int applicationId,
    required String status,
    String? description,
  });
}
