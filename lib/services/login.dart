import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iotcontroller/model/login.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/services/shared_cache.dart';

class LoginService {
  static var client = http.Client();
  //request server for login

  static Future<UserModel> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.https(Config.baseURL, Config.authLogin);

    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model.toJson()));

    final loginDetails = loginResponseJson(response.body);

    await SharedCache.setLoginDetails(loginDetails);
    return loginDetails; // map json data to dart model.
  }
}
