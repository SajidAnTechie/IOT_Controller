class ToogleSwitch {
  String id;
  bool isOn;

  ToogleSwitch({this.id, this.isOn});

  Map<String, dynamic> toJson() {
    return {"id": id, "isOn": isOn};
  }
}
