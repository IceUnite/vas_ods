import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:vas_ods/feature/main_page/data/api/order_api.dart';
import 'package:vas_ods/feature/main_page/data/models/order_service_model.dart';


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
      if (response.statusCode == 204 || response.statusCode == 200 ) {
       return response.data;
      } else {
        throw Exception('Ошибка проверки токена');
      }
    } catch (e) {
      throw Exception('Ошибка при выполнении запроса: $e');
    }
  }

}
