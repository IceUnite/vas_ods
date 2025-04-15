import 'package:vas_ods/feature/main_page/data/models/order_service_model.dart';

abstract class OrderApi {
  Future<OrderServiceModel?> getApplicationsByDate({
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
