class ApplianceLogModel {
  String status;
  List<ApplianceLogData> data;
  ApplianceLogModel({this.status, this.data});

  factory ApplianceLogModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];

    final dataList = List<ApplianceLogData>.from(
        data.map((applianceLog) => ApplianceLogData.fromJson(applianceLog)));

    return ApplianceLogModel(status: json['status'], data: dataList);
  }
}

class ApplianceLogData {
  String name;
  int totalPowerConsumed;
  int pin;
  String image;
  int power;

  ApplianceLogData(
      {this.name, this.totalPowerConsumed, this.pin, this.image, this.power});

  factory ApplianceLogData.fromJson(Map<String, dynamic> json) {
    return ApplianceLogData(
        name: json['name'],
        totalPowerConsumed: json['totalPowerConsumed'],
        pin: json['pin'],
        image: json['image'],
        power: json['power']);
  }
}
