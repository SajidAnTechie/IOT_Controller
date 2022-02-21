import 'package:flutter/material.dart';
import 'package:iotcontroller/model/appliance.dart';

class Controller extends StatefulWidget {
  final ApplianceData appliance;
  final Function toogleSwitch;
  const Controller({this.appliance, this.toogleSwitch, Key key})
      : super(key: key);

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  bool _isLightOn = false;

  void toogleSwitch(bool value) {
    widget.toogleSwitch(value, widget.appliance.id);
  }

  @override
  Widget build(BuildContext context) {
    final power = widget.appliance.power;
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
              widget.appliance.isOn
                  ? widget.appliance.image2
                  : widget.appliance.image1,
            ),
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.appliance.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text("$power W",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold)),
          Switch(
              value: widget.appliance.isOn,
              activeColor: Colors.yellow,
              inactiveThumbColor: Colors.grey.shade200,
              inactiveTrackColor: Colors.grey.shade400,
              onChanged: toogleSwitch)
        ]),
      ),
    );
  }
}
