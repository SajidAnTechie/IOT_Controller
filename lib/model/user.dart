import 'dart:convert';
import 'package:iotcontroller/model/loginResponseData.dart';

class UserModel {
  String status;
  LoginResponseData data;

  UserModel({this.status, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = LoginResponseData.fromJson(json['data']);
    return UserModel(status: json['status'], data: data);
  }
}

UserModel loginResponseJson(String str) {
  return UserModel.fromJson(jsonDecode(str));
}
