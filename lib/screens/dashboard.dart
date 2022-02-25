import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:iotcontroller/providers/appliance_log_provider.dart';

class Dashboard extends StatelessWidget {
  final DateTime initialDate;
  const Dashboard({
    this.initialDate,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Appliances Logs"),
          SizedBox(
            height: 50,
          ),
          Text('${initialDate.year}/${initialDate.month}'),
          Consumer<ApplianceLogProvider>(builder: (context, data, child) {
            final appliancelogs = data.applianceLogData.data;

            return appliancelogs.isEmpty
                ? Center(
                    child: Text(
                        "You have no logs for ${initialDate.year}/${initialDate.month}."),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: appliancelogs.length,
                      itemBuilder: (ctx, index) {
                        final appliance = appliancelogs[index];
                        return ListTile(
                          leading: Image.network(appliance.image, height: 50),
                          title: Text(appliance.name),
                          trailing:
                              Text(appliance.totalPowerConsumed + " units"),
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
