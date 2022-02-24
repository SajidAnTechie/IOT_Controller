import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iotcontroller/providers/appliance_log_provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Container(
            child: Center(child: Text("Appliances Logs")),
          ),
          SizedBox(
            height: 50,
          ),
          Consumer<ApplianceLogProvider>(builder: (context, data, child) {
            final appliancelogs = data.applianceLogData.data;

            return Expanded(
              child: ListView.separated(
                itemCount: appliancelogs.length,
                itemBuilder: (ctx, index) {
                  final appliance = appliancelogs[index];
                  return ListTile(
                    leading: Image.network(appliance.image, height: 50),
                    title: Text(appliance.name),
                    trailing: Text(appliance.totalPowerConsumed + " units"),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            );
          }),
        ],
      ),
    );
  }
}
