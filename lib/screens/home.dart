import 'package:flutter/material.dart';
import 'package:iotcontroller/screens/controllers.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown.shade900,
        appBar: AppBar(
          backgroundColor: Colors.brown.shade900,
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
                      backgroundColor: Colors.brown.shade800,
                      child: const Text('SA'),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("Sajid Ansari",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ],
                )
              ]),
            ),
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: 50,
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
        ));
  }
}
