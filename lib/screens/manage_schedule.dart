import 'package:flutter/material.dart';
import 'package:iotcontroller/components/ShowAlertDialog.dart';
import 'package:iotcontroller/components/drop_down.dart';
import 'package:iotcontroller/components/input_password_field.dart';
import 'package:iotcontroller/components/input_text_field.dart';
import 'package:iotcontroller/components/rounded_button.dart';
import 'package:iotcontroller/constants/colors.dart';
import 'package:iotcontroller/model/appliance.dart';
import 'package:iotcontroller/model/schedule.dart';
import 'package:iotcontroller/providers/appliance_provider.dart';
import 'package:iotcontroller/services/schedule.dart';
import 'package:iotcontroller/validators/inputField.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ManageSchedule extends StatefulWidget {
  const ManageSchedule({Key key}) : super(key: key);

  @override
  _ManageScheduleState createState() => _ManageScheduleState();
}

class _ManageScheduleState extends State<ManageSchedule> {
  final _formKey = GlobalKey<FormState>();
  bool _isAsyncCall = false;
  String alarmTime;
  bool _isOn = false;
  int pin;
  String applianceId;
  bool _repeat = false;
  ApplianceData selectedAppliance;

  void shouldOnOffHandler(bool value) {
    setState(() {
      _isOn = value;
    });
  }

  void shouldRepeatHandler(bool value) {
    setState(() {
      _repeat = value;
    });
  }

  void onDropDownSelect(String value) {
    final selectedApplianceData =
        Provider.of<ApplianceProvider>(context, listen: false)
            .getApplianceDataById(value);
    setState(() {
      applianceId = value;
      pin = selectedApplianceData.pin;
      selectedAppliance = selectedApplianceData;
    });
  }

  Future<void> _submit() async {
    // dismiss keyboard during async call
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isAsyncCall = true;
    });
    final body = ScheduleModel(
        id: applianceId,
        alarmTime: alarmTime,
        pin: pin,
        isOn: _isOn ? 1 : 0,
        repeat: _repeat ? 1 : 0);

    try {
      final token = Provider.of<ApplianceProvider>(context, listen: false)
          .authData
          .data
          .token;
      final response = await ScheduleService.setSchedule(body, token);

      if (response != null) {
        _formKey.currentState.reset();
        AlertDialogComponent.dialog(context,
            "Successfully set schedule for appliance ${selectedAppliance.name}");
      }
    } catch (err) {
      print(err);
      AlertDialogComponent.dialog(context, "Incorrect email/password.");
    } finally {
      setState(() {
        _isAsyncCall = false;
        pin = null;
        _isOn = false;
        _repeat = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items =
        Provider.of<ApplianceProvider>(context, listen: false).applianceList;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Manage Schedule",
            style: TextStyle(
              fontSize: 20,
            )),
        elevation: 0,
      ),
      body: ModalProgressHUD(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  InputTextField(
                      hintText: "Enter time",
                      onChanged: (value) => {alarmTime = value},
                      icon: Icons.timelapse,
                      validator: InputFieldValidator.alarmTimeFiled),
                  DropDown(
                      hintText: "Select Appliance",
                      onChanged: onDropDownSelect,
                      icon: Icons.arrow_drop_down,
                      itemList: items.data,
                      validator: InputFieldValidator.applianceDropDown),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          "On/Off",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Switch(
                          value: _isOn,
                          activeColor: Colors.yellow,
                          inactiveThumbColor: Colors.grey.shade200,
                          inactiveTrackColor: Colors.grey.shade400,
                          onChanged: shouldOnOffHandler,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      children: [
                        Text(
                          "Repeat",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                        Switch(
                          value: _repeat,
                          activeColor: Colors.yellow,
                          inactiveThumbColor: Colors.grey.shade200,
                          inactiveTrackColor: Colors.grey.shade400,
                          onChanged: shouldRepeatHandler,
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                    press: () {
                      if (_formKey.currentState.validate()) {
                        print("Ok");
                        _submit();
                      } else {
                        print("Not ok");
                      }
                    },
                    text: "Done",
                  ),
                ],
              ),
            ),
          ),
        ),
        inAsyncCall: _isAsyncCall,
        progressIndicator: CircularProgressIndicator(),
        opacity: 0.5,
      ),
    );
  }
}
