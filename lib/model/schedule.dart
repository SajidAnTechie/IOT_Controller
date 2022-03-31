class ScheduleModel {
  String id;
  String alarmTime;
  int isOn;
  int pin;
  int repeat;

  ScheduleModel({this.id, this.alarmTime, this.isOn, this.pin, this.repeat});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "alarmTime": alarmTime,
      "isOn": isOn,
      "pin": pin,
      "repeat": repeat
    };
  }
}
