// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceModel _$PriceModelFromJson(Map<String, dynamic> json) => PriceModel(
      price: json['price'] as String?,
      brand: json['brand'] as String?,
      color: json['color'] as String?,
      name: json['name'] as String?,
      id: json['id'] as String?,
      dateTime: json['dateTime'] as String?,
      image: json['image'] as String?,
      status: json['status'] as String?,
      warranty: json['warranty'] as String?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$PriceModelToJson(PriceModel instance) =>
    <String, dynamic>{
      'price': instance.price,
      'brand': instance.brand,
      'color': instance.color,
      'dateTime': instance.dateTime,
      'id': instance.id,
      'notes': instance.notes,
      'name': instance.name,
      'image': instance.image,
      'status': instance.status,
      'warranty': instance.warranty,
    };
