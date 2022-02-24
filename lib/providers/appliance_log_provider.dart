import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:iotcontroller/model/user.dart';
import 'package:iotcontroller/model/appliance_log.dart';
import 'package:iotcontroller/services/applianceLogServices.dart';
import 'package:iotcontroller/services/shared_cache.dart';

class ApplianceLogProvider with ChangeNotifier {
  ApplianceLogModel _applianceLogData;
  UserModel authData;

  ApplianceLogModel get applianceLogData => _applianceLogData;

  Future<void> getApplianceLogData(BuildContext context) async {
    try {
      authData = await SharedCache.getLoginDetails(context);
      _applianceLogData =
          await ApplianceLogServices.getApplianceLog(authData.data.token);
    } catch (err) {
      print(err);
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                elevation: 5,
                content: Text("Something went wrong !!!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'OK');
                      },
                      child: Text("Ok")),
                ],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
              ));
    }
  }
}
