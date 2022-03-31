import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iotcontroller/screens/home.dart';
import 'package:iotcontroller/screens/login.dart';
import 'package:iotcontroller/config/appConfig.dart';
import 'package:iotcontroller/screens/register.dart';
import 'package:page_transition/page_transition.dart';
import 'package:iotcontroller/screens/verify_email.dart';
import 'package:iotcontroller/services/shared_cache.dart';
import 'package:iotcontroller/screens/manage_schedule.dart';
import 'package:iotcontroller/providers/appliance_provider.dart';
import 'package:iotcontroller/providers/appliance_log_provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
        }),
        ChangeNotifierProvider(create: (BuildContext context) {
          return ApplianceLogProvider();
        })
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Sans Fill",
        theme: ThemeData(primaryColor: Colors.white),
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: Image.asset("assets/images/logo.png"),
          nextScreen: defaultWidget,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
        routes: {
          '/home': (context) => Home(),
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/verify-email': (context) => VerifyEmail(),
          '/manage-schedule': (context) => ManageSchedule()
        },
      ),
    );
  }
}
