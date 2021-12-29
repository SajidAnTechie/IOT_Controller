import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iotcontroller/screens/appliance.dart';
import 'package:iotcontroller/providers/appliance_provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _setIndex = 0;
  bool _isInit = true;
  Future _fetchData;

  void onItemTab(value) {
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
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          elevation: 0,
          automaticallyImplyLeading: false),
      body: FutureBuilder(
          future: _fetchData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : Consumer<ApplianceProvider>(builder: (context, data, child) {
                    final authData = data.authData.data;
                    final applianceList = data.applianceList.data;
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.grey.withOpacity(0.5),
                                //     spreadRadius: 5,
                                //     blurRadius: 7,
                                //     offset: Offset(0, 3), // changes position of shadow
                                //   ),
                                // ],
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: GridView.builder(
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
                                  final appliance = applianceList[index];
                                  return Controller(appliance: appliance);
                                }),
                          ),
                        ),
                      ],
                    );
                  });
          }),
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
            icon: Icon(Icons.settings),
            label: 'Settings',
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
    );
  }
}
