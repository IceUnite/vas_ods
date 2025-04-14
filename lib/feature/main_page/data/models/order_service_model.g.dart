// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderServiceModel _$OrderServiceModelFromJson(Map<String, dynamic> json) =>
    OrderServiceModel(
      code: (json['code'] as num).toInt(),
      data: (json['data'] as List<dynamic>)
          .map((e) => OrderServiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderServiceModelToJson(OrderServiceModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'data': instance.data,
    };

OrderServiceItem _$OrderServiceItemFromJson(Map<String, dynamic> json) =>
    OrderServiceItem(
      id: (json['id'] as num).toInt(),
      idDoc: (json['id_doc'] as num).toInt(),
      description: json['description'] as String,
      createdAt: json['created_at'] as String,
      idUser: (json['id_user'] as num).toInt(),
      status: json['status'] as String,
      date: json['date'] as String,
      updatedAt: json['updated_at'] as String,
    );

Map<String, dynamic> _$OrderServiceItemToJson(OrderServiceItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'id_doc': instance.idDoc,
      'description': instance.description,
      'created_at': instance.createdAt,
      'id_user': instance.idUser,
      'status': instance.status,
      'date': instance.date,
      'updated_at': instance.updatedAt,
    };
