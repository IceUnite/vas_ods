
import 'package:vas_ods/feature/auth_page/domain/entities/refresh_token_entitie.dart' show TokenEntity;

import '../../data/models/order_service_model.dart';

abstract class OrderRepository {
  Future<OrderServiceModel?> getApplicationsByDate({
    required int userId,
    required String token,
    required String date,
  });


}
