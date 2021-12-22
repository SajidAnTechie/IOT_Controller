import 'dart:convert';

import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/model/login.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:http/http.dart' as http;

class LoginService {
  static var client = http.Client();
  //request server for login

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.baseURL, Config.authLogin);

    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    print(response);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    //return loginResponseMapToDart(response.body);
  }
}
