import 'dart:convert';
import 'package:iotcontroller/model/loginResponseData.dart';

class UserModel {
  String id;
  String name;
  String email;
  String token;

  UserModel({this.id, this.name, this.email, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = LoginResponseData.fromJson(json['data']);
    return UserModel(
        id: data.id, name: data.name, email: data.email, token: data.token);
  }
}

UserModel loginResponseJson(String str) {
  return UserModel.fromJson(jsonDecode(str));
}
