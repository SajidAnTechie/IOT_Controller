import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iotcontroller/providers/appliance_provider.dart';
import 'package:iotcontroller/screens/home.dart';
import 'package:iotcontroller/screens/login.dart';
import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/services/shared_cache.dart';

Widget defaultWidget = const Login();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await SharedCache.isKeyExit(Config.apiCachedLoginKey);

  if (isLoggedIn) {
    defaultWidget = Home();
  }
  runApp(IotController());
}

class IotController extends StatelessWidget {
  const IotController({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) {
          return ApplianceProvider();
        })
      ],
      child: MaterialApp(
        title: "IOT Controller",
        theme: ThemeData(primaryColor: Colors.white),
        home: defaultWidget,
        routes: {'/home': (context) => Home()},
      ),
    );
  }
}
