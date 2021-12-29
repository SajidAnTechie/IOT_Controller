import 'package:flutter/material.dart';
import 'package:iotcontroller/model/appliance.dart';

class Controller extends StatefulWidget {
  final ApplianceData appliance;
  const Controller({this.appliance, Key key}) : super(key: key);

  @override
  _ControllerState createState() => _ControllerState();
}

class _ControllerState extends State<Controller> {
  bool _isLightOn = false;

  void toogleSwitch(bool value) {
    setState(() {
      _isLightOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              _isLightOn ? widget.appliance.image2 : widget.appliance.image1,
            ),
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.appliance.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text("Whitenoise",
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
