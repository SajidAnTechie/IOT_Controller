import 'package:flutter/material.dart';
import 'package:iotcontroller/screens/model/controller.dart';

class Controller extends StatefulWidget {
  final ControllerModel controller;
  const Controller({this.controller, Key key}) : super(key: key);

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
            image: AssetImage(
              _isLightOn ? widget.controller.img1 : widget.controller.img2,
            ),
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 10,
          ),
          Text(widget.controller.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          Text("Whitenoise",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.bold)),
          Switch(
              value: _isLightOn,
              activeColor: Colors.yellow,
              inactiveThumbColor: Colors.grey.shade200,
              inactiveTrackColor: Colors.grey.shade400,
              onChanged: toogleSwitch)
        ]),
      ),
    );
  }
}
