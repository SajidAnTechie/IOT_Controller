import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:iotcontroller/model/schedule.dart';
import 'package:iotcontroller/config/appConfig.dart';

class ScheduleService {
  static var client = http.Client();

  static Future<bool> setSchedule(ScheduleModel model, String token) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var url = Uri.https(Config.baseURL, Config.setSchedule);
    print(url);
    final response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));
    return true;
  }
}
