class UserModel {
  String id;
  String name;
  String email;
  String token;

  UserModel({this.id, this.name, this.email, this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        token: json['token']);
  }
}
