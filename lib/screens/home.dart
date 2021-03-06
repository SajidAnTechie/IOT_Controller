import 'package:flutter/material.dart';
import 'package:iotcontroller/constants/colors.dart';
import 'package:provider/provider.dart';
import 'package:iotcontroller/screens/dashboard.dart';
import 'package:iotcontroller/screens/appliance.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:iotcontroller/services/shared_cache.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:iotcontroller/components/ShowAlertDialog.dart';
import 'package:iotcontroller/model/toogle_switch_request.dart';
import 'package:iotcontroller/providers/appliance_provider.dart';
import 'package:iotcontroller/providers/appliance_log_provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _setIndex = 0;
  bool _isAsyncCall = false;
  bool _isInit = true;
  Future _fetchData;
  DateTime initialDate = DateTime.now();
  final isDialOpen = ValueNotifier(false);

  Future<void> onItemTab(value) async {
    if (value == 2) {
      await SharedCache.logout(context);
      return;
    }
    setState(() {
      _setIndex = value;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _fetchData = Provider.of<ApplianceProvider>(context, listen: false)
          .getAuthAppliances(context);
      _fetchData = Provider.of<ApplianceLogProvider>(context, listen: false)
          .getApplianceLogData(context, initialDate);
    }
    _isInit = false;
  }

  Future<void> toggleSwitch(bool isOn, String id) async {
    ToogleSwitch requestData = ToogleSwitch(id: id, isOn: isOn);
    setState(() {
      _isAsyncCall = true;
    });
    try {
      await Provider.of<ApplianceProvider>(context, listen: false)
          .updateSwitchState(context, requestData);
    } catch (err) {
      print(err);
      AlertDialogComponent.dialog(context, "Something went wrong !!!");
    } finally {
      setState(() {
        _isAsyncCall = false;
      });
    }
  }

  Future<void> getAppliancesLogsByDate(DateTime selectedDate) async {
    setState(() {
      _isAsyncCall = true;
      initialDate = selectedDate;
    });
    try {
      await Provider.of<ApplianceLogProvider>(context, listen: false)
          .getApplianceLogData(context, selectedDate);
    } catch (err) {
      print(err);
      AlertDialogComponent.dialog(context, "Something went wrong !!!");
    } finally {
      setState(() {
        _isAsyncCall = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
            backgroundColor: Colors.grey.shade900,
            elevation: 0,
            automaticallyImplyLeading: false),
        body: ModalProgressHUD(
          child: FutureBuilder(
              future: _fetchData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : Consumer<ApplianceProvider>(
                        builder: (context, data, child) {
                        final authData = data.authData.data;
                        final applianceList = data.applianceList.data;
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Column(children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Welcome Home",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.grey.shade800,
                                      child: const Text('SA'),
                                    )
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(authData.name,
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  child: _setIndex == 0
                                      ? applianceList.length > 0
                                          ? GridView.builder(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 30),
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10,
                                              ),
                                              itemCount: applianceList.length,
                                              itemBuilder: (ctx, index) {
                                                final appliance =
                                                    applianceList[index];
                                                return Controller(
                                                    appliance: appliance,
                                                    toggleSwitch: toggleSwitch);
                                              })
                                          : Center(
                                              child: Text(
                                                  "You have no any appliances register yet.",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .grey.shade700)))
                                      : Dashboard(initialDate: initialDate)),
                            ),
                          ],
                        );
                      });
              }),
          inAsyncCall: _isAsyncCall,
          progressIndicator: CircularProgressIndicator(),
          opacity: 0.5,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Log out',
            ),
          ],
          backgroundColor: Colors.grey.shade900,
          currentIndex: _setIndex,
          selectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(size: 40),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          elevation: 0,
          unselectedItemColor: Colors.grey.shade500,
          mouseCursor: SystemMouseCursors.grab,
          onTap: (value) {
            onItemTab(value);
          },
        ),
        floatingActionButton: _setIndex == 1
            ? Builder(
                builder: (context) => FloatingActionButton(
                      child: Icon(Icons.calendar_today),
                      onPressed: () async {
                        showMonthPicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 2, 5),
                          lastDate: DateTime(DateTime.now().year, 9),
                          initialDate: initialDate,
                          locale: Locale("en"),
                        ).then((date) {
                          if (date != null) {
                            getAppliancesLogsByDate(date);
                          }
                        });
                      },
                    ))
            : _setIndex == 0
                ? SpeedDial(
                    animatedIcon: AnimatedIcons.menu_close,
                    overlayColor: Colors.black,
                    overlayOpacity: 0.5,
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    curve: Curves.bounceIn,
                    openCloseDial: isDialOpen,
                    children: [
                      SpeedDialChild(
                        labelStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                        child: Icon(Icons.schedule),
                        label: 'Manage schedule',
                        onTap: () =>
                            {Navigator.pushNamed(context, '/manage-schedule')},
                      )
                    ],
                  )
                : Container(),
      ),
    );
  }
}
