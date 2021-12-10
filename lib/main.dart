import 'package:flutter/material.dart';
import 'package:iotcontroller/screens/home.dart';

void main() {
  runApp(IotController());
}

class IotController extends StatelessWidget {
  const IotController({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IOT Controller",
      theme: ThemeData(primaryColor: Colors.white),
      home: Home(),
    );
  }
}
