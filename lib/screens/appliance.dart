import 'package:flutter/material.dart';
import 'package:iotcontroller/model/appliance.dart';
import 'package:iotcontroller/model/toogle_switch_request.dart';

class Controller extends StatelessWidget {
  final ApplianceData appliance;
  final Function toogleSwitch;
  const Controller({this.appliance, this.toogleSwitch, Key key})
      : super(key: key);

  void toogleSwitchHandler(bool value) {
    toogleSwitch(value, appliance.id);
  }

  @override
  Widget build(BuildContext context) {
    final power = appliance.power;
    return Card(
      color: Colors.grey.shade200,
      elevation: 4,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 10,
          ),
          Image(
            image: NetworkImage(
              appliance.isOn ? appliance.image2 : appliance.image1,
            ),
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Text(appliance.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text("$power W",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold)),
          Switch(
              value: appliance.isOn,
              activeColor: Colors.yellow,
              inactiveThumbColor: Colors.grey.shade200,
              inactiveTrackColor: Colors.grey.shade400,
              onChanged: toogleSwitchHandler)
        ]),
      ),
    );
  }
}
