import 'package:json_annotation/json_annotation.dart';
part "price_model.g.dart";
@JsonSerializable()
class PriceModel{
  final String? price;
  final String? brand;
  final String? color;
  final String? dateTime;
  final String? id;
  final String? notes;
  final String? name;
  final String? image;
  final String? status;
  final String? warranty;

  PriceModel({
    this.price,
    this.brand,
    this.color,
    this.name,
    this.id,
    this.dateTime,
    this.image,
    this.status,
    this.warranty,
    this.notes
  });
  factory PriceModel.fromJson(Map<String,dynamic>json)=> _$PriceModelFromJson(json);
  Map<String,dynamic>toJson()=> _$PriceModelToJson(this);
}