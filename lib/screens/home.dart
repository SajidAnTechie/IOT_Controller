import 'package:flutter/material.dart';
import 'package:iotcontroller/screens/controllers.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _setIndex = 0;

  void onItemTab(int index) {
    setState(() {
      _setIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        elevation: 0,
      ),
      body: Column(
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
                child: Text("Sajid Ansari",
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
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 10,
                  itemBuilder: (ctx, index) {
                    return Controller();
                  }),
            ),
          ),
        ],
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