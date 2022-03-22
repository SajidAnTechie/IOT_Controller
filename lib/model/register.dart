class RegisterModel {
  String name;
  String email;
  String address;
  String password;

  RegisterModel({this.name, this.email, this.address, this.password});
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "address": address,
      "password": password
    };
  }
}
