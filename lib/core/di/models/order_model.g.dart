// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      phone: json['phone'] as String?,
      number: (json['number'] as num?)?.toInt(),
      brand: json['brand'] as String?,
      color: json['color'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
      dateTime: json['dateTime'] as String?,
      image: json['image'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'number': instance.number,
      'brand': instance.brand,
      'color': instance.color,
      'dateTime': instance.dateTime,
      'id': instance.id,
      'notes': instance.notes,
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
    };
