import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_service_model.g.dart';

@immutable
@JsonSerializable()
class OrderServiceModel {
  final int? code;
  final List<OrderServiceItem>? data;

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
  final int? id;

  @JsonKey(name: 'id_doc')
  final int? idDoc;

  final String? description;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'id_user')
  final int? idUser;

  final String? status;

  final String? date;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  // Добавление вложенных объектов
  final User? user;
  final Document? document;

  const OrderServiceItem({
    required this.id,
    required this.idDoc,
    required this.description,
    required this.createdAt,
    required this.idUser,
    required this.status,
    required this.date,
    required this.updatedAt,
    required this.user,
    required this.document,
  });

  factory OrderServiceItem.fromJson(Map<String, dynamic> json) =>
      _$OrderServiceItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderServiceItemToJson(this);
}

@immutable
@JsonSerializable()
class User {
  final int? id;
  final String? name;
  final String? middleName;
  final String? phone;

  const User({
    required this.id,
    this.name,
    this.middleName,
    this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@immutable
@JsonSerializable()
class Document {
  final int? id;
  final String? name;
  final String? description;
  @JsonKey(name: 'min_time')
  final String? minTime;

  const Document({
    required this.id,
    required this.name,
    required this.description,
    required this.minTime,
  });

  factory Document.fromJson(Map<String, dynamic> json) =>
      _$DocumentFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentToJson(this);
}
