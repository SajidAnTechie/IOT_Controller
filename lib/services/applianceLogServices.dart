import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/model/appliance_log.dart';

class ApplianceLogServices {
  static var client = http.Client();

  static Future<ApplianceLogModel> getApplianceLog(String token) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.baseURL, Config.applianceLog);

    final response = await client.get(url, headers: requestHeaders);

    return ApplianceLogModel.fromJson(jsonDecode(response.body));
  }
}
