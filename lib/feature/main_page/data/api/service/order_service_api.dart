import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:vas_ods/feature/main_page/data/models/order_service_model.dart';

import '../order_api.dart';

@lazySingleton
class OrderApiDioService implements OrderApi {
  final Dio dio;

  OrderApiDioService(this.dio);

  @override
  Future<OrderServiceModel?> getApplicationsByDate({
    required int userId,
    required String token,
    required String date,
  }) async {
    try {
      final response = await dio.get(
        '/applications/get_applications_by_date',
        queryParameters: {
          "id_user": userId,
          "token": token,
          "date": date,
        },
      );
      if (response.statusCode == 204 || response.statusCode == 200) {
        return OrderServiceModel.fromJson(response.data);
      } else {
        throw Exception('Ошибка проверки токена');
      }
    } catch (e) {
      throw Exception('Ошибка при выполнении запроса: $e');
    }
  }

  // Новый метод
  Future<void> updateApplication({
    required int userId,
    required String token,
    required int applicationId,
    required String status,
    String? description,
  }) async {
    try {
      final response = await dio.post(
        '/applications/update_application',
        queryParameters: {
          "id_user": userId,
          "token": token,
          "id_app": applicationId,
          "stat": status,
          if (description != null) "description": description,
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Не удалось обновить заявку');
      }
    } catch (e) {
      throw Exception('Ошибка при обновлении заявки: $e');
    }
  }
}
