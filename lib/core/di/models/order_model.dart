import 'package:json_annotation/json_annotation.dart';
part "order_model.g.dart";
@JsonSerializable()
class OrderModel{
  final String? phone;
  final int? number;
  final String? brand;
  final String? color;
  final String? dateTime;
  final String? id;
  final String? notes;
  final String? name;
  final String? image;
  final String? status;

  OrderModel({
    this.phone,
    this.number,
    this.brand,
    this.color,
    this.name,
    this.id,
    this.dateTime,
    this.image,
    this.status,
    this.notes
  });
  factory OrderModel.fromJson(Map<String,dynamic>json)=> _$OrderModelFromJson(json);
  Map<String,dynamic>toJson()=> _$OrderModelToJson(this);
}