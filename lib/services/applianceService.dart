import 'package:http/http.dart' as http;
import 'package:iotcontroller/model/appliance.dart';
import 'package:iotcontroller/config/appConfig.dart';

class ApplianceService {
  static var client = http.Client();

  static Future<ApplianceModel> getAuthAppliances(String token) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.baseURL, Config.authAppliace);

    final response = await client.get(url, headers: requestHeaders);

    return applianceListResponse(
        response.body); // map json data to dart model.;
  }

  static Future<ApplianceData> updateSwitchState(
      String data, String token) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var url = Uri.https(Config.baseURL, Config.updateAppliance);

    final response = await client.put(url, body: data, headers: requestHeaders);
    final updatedAppliance =
        applianceResponse(response.body); // map json data to dart model.

    return updatedAppliance.data;
  }
}
