import 'dart:convert';

class UserModel {
  String status;
  LoginResponseData data;

  UserModel({this.status, this.data});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final data = LoginResponseData.fromJson(json['data']);
    return UserModel(status: json['status'], data: data);
  }
  Map<String, dynamic> toJson() {
    return {'status': status, 'data': data.toJson()};
  }
}

UserModel loginResponseJson(String str) {
  return UserModel.fromJson(jsonDecode(str));
}

class LoginResponseData {
  String id;
  String name;
  String email;
  String token;

  LoginResponseData({this.id, this.email, this.name, this.token});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        token: json['token']);
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'token': token};
  }
}
