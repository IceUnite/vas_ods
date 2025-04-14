import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_service_model.g.dart';

@immutable
@JsonSerializable()
class OrderServiceModel {
  final int code;
  final List<OrderServiceItem> data;

  const OrderServiceModel({
    required this.code,
    required this.data,
  });

  factory OrderServiceModel.fromJson(Map<String, dynamic> json) =>
      _$OrderServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderServiceModelToJson(this);
}

@immutable
@JsonSerializable()
class OrderServiceItem {
  final int id;

  @JsonKey(name: 'id_doc')
  final int idDoc;

  final String description;

  @JsonKey(name: 'created_at')
  final String createdAt;

  @JsonKey(name: 'id_user')
  final int idUser;

  final String status;

  final String date;

  @JsonKey(name: 'updated_at')
  final String updatedAt;

  const OrderServiceItem({
    required this.id,
    required this.idDoc,
    required this.description,
    required this.createdAt,
    required this.idUser,
    required this.status,
    required this.date,
    required this.updatedAt,
  });

  factory OrderServiceItem.fromJson(Map<String, dynamic> json) =>
      _$OrderServiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderServiceItemToJson(this);
}
