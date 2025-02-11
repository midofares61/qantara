import 'package:json_annotation/json_annotation.dart';
part "user_model.g.dart";
@JsonSerializable()
class UserModel{
  final String? phone;
  final String? password;
  final String? firstName;
  final String? lastName;

  UserModel({
    this.phone,
    this.password,
    this.firstName,
    this.lastName,
});
  factory UserModel.fromJson(Map<String,dynamic>json)=> _$UserModelFromJson(json);
  Map<String,dynamic>toJson()=> _$UserModelToJson(this);
}