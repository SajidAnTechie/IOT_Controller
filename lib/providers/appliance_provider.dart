import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iotcontroller/model/toogle_switch_request.dart';
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

  Future<void> updateSwitchState(
      BuildContext context, ToogleSwitch model) async {
    final response = await ApplianceService.updateSwitchState(
        jsonEncode(model), authData.data.token);
    final index =
        _applianceList.data.indexWhere((appliacne) => model.id == appliacne.id);
    _applianceList.data[index] = response;

    notifyListeners();
  }
}
