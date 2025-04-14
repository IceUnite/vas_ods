

import 'package:vas_ods/feature/main_page/data/models/order_service_model.dart';

class OrderServiceEntity extends OrderServiceModel {
  const OrderServiceEntity({
    required int code,
    required List<OrderServiceItem> data,
  }) : super(
    code: code,
    data: data,
  );
}
