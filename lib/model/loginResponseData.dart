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
}
