import 'dart:convert';

class ApplianceModel {
  String status;
  List<ApplianceData> data;

  ApplianceModel({this.status, this.data});

  factory ApplianceModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> data = json['data'];
    final dataList = List<ApplianceData>.from(
        data.map((appliance) => ApplianceData.fromJson(appliance)));
    return ApplianceModel(status: json['status'], data: dataList);
  }
}

ApplianceModel applianceListResponse(String str) {
  return ApplianceModel.fromJson(jsonDecode(str));
}

class ApplianceData {
  String id;
  String name;
  int pin;
  String image1;
  String image2;
  bool isOn;
  String timeLapsed;

  ApplianceData({
    this.id,
    this.name,
    this.pin,
    this.image1,
    this.image2,
    this.isOn,
    this.timeLapsed,
  });

  factory ApplianceData.fromJson(Map<String, dynamic> json) {
    return ApplianceData(
        id: json['_id'],
        name: json['name'],
        pin: json['pin'],
        image1: json['image1'],
        image2: json['image2'],
        isOn: json['isOn'],
        timeLapsed: json['timeLapsed'] != null ? json['timeLapsed'] : "");
  }
}

class ApplianceResponseData {
  String status;
  ApplianceData data;
  ApplianceResponseData({this.status, this.data});

  factory ApplianceResponseData.fromJson(Map<String, dynamic> json) {
    final data = ApplianceData.fromJson(json['data']);
    return ApplianceResponseData(status: json['status'], data: data);
  }
}

ApplianceResponseData applianceResponse(String str) {
  return ApplianceResponseData.fromJson(jsonDecode(str));
}

List<ApplianceData> controllerLists = [
  ApplianceData(
      name: "Light",
      pin: 4,
      image1: "assets/bulb3.png",
      image2: "assets/bulb4.png"),
  ApplianceData(
      name: "Fan",
      pin: 4,
      image1: "assets/bulb1.png",
      image2: "assets/bulb2.png")
];
