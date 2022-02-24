import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iotcontroller/providers/appliance_provider.dart';
import 'package:iotcontroller/screens/home.dart';
import 'package:iotcontroller/screens/login.dart';
import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/services/shared_cache.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

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
        debugShowCheckedModeBanner: false,
        title: "IOT Controller",
        theme: ThemeData(primaryColor: Colors.white),
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset("assets/images/logo.png"),
          nextScreen: defaultWidget,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
        routes: {'/home': (context) => Home(), '/login': (context) => Login()},
      ),
    );
  }
}
