import 'package:flutter/widgets.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/model/appliance.dart';
import 'package:iotcontroller/services/applianceService.dart';
import 'package:iotcontroller/services/shared_cache.dart';

class ApplianceProvider with ChangeNotifier {
  ApplianceModel _applianceList;
  UserModel authData;

  ApplianceModel get applianceList => _applianceList;

  Future<void> getAuthAppliances(BuildContext context) async {
    try {
      authData = await SharedCache.getLoginDetails(context);

      _applianceList =
          await ApplianceService.getAuthAppliances(authData.data.token);
    } catch (err) {
      print(err);
    }
  }
}
