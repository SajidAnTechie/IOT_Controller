import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iotcontroller/model/login.dart';
import 'package:iotcontroller/model/register.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/services/shared_cache.dart';

class RegisterService {
  static var client = http.Client();

  static Future<bool> register(RegisterModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.https(Config.baseURL, Config.register);

    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    return true;
  }
}
