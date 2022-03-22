import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iotcontroller/model/login.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/services/shared_cache.dart';

class VerifyService {
  static var client = http.Client();
  //request server for login

  static Future<UserModel> verify(String code) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.https(Config.baseURL, Config.verify);

    Map<String, dynamic> body = {"verificationCode": code};

    final response =
        await client.post(url, headers: requestHeaders, body: jsonEncode(body));

    final loginDetails = loginResponseJson(response.body);

    await SharedCache.setLoginDetails(loginDetails);
    return loginDetails; // map json data to dart model.
  }
}
