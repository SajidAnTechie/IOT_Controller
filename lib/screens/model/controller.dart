class ControllerModel {
  String name;
  String url;
  String img1;
  String img2;

  ControllerModel({this.name, this.url, this.img1, this.img2});
}

List<ControllerModel> controllerLists = [
  ControllerModel(
      name: "Light",
      url: "",
      img1: "assets/bulb3.png",
      img2: "assets/bulb4.png"),
  ControllerModel(
      name: "Fan", url: "", img1: "assets/bulb1.png", img2: "assets/bulb2.png")
];
