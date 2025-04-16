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
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      document: Document.fromJson(json['document'] as Map<String, dynamic>),
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
      'user': instance.user,
      'document': instance.document,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      middleName: json['middleName'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'middleName': instance.middleName,
      'phone': instance.phone,
    };

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
      minTime: json['min_time'] as String,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'min_time': instance.minTime,
    };
