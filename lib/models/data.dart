import 'main_service.dart';

class Data {
  String? id;
  String? name;
  String? email;
  String? username;
  String? code;
  String? mobile;
  String? mainServiceId;
  MainService? mainService;
  double? km;
  String? address;
  String? orderOpeningTime;
  String? orderClosingTime;
  int? isActive;
  int? isClosed;
  String? coverImage;
  String? logoImage;
  String? lat;
  String? lng;

  Data(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.code,
      this.mobile,
      this.mainServiceId,
      this.mainService,
      this.km,
      this.address,
      this.orderOpeningTime,
      this.orderClosingTime,
      this.isActive,
      this.isClosed,
      this.coverImage,
      this.logoImage,
      this.lat,
      this.lng});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    code = json['code'];
    mobile = json['mobile'];
    mainServiceId = json['main_service_id'];
    mainService = json['main_service'] != null
        ? MainService.fromJson(json['main_service'])
        : null;
    km = json['km'];
    address = json['address'];
    orderOpeningTime = json['order_opening_time'];
    orderClosingTime = json['order_closing_time'];
    isActive = json['is_active'];
    isClosed = json['is_closed'];
    coverImage = json['cover_image'];
    logoImage = json['logo_image'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['username'] = username;
    data['code'] = code;
    data['mobile'] = mobile;
    data['main_service_id'] = mainServiceId;
    if (mainService != null) {
      data['main_service'] = mainService!.toJson();
    }
    data['km'] = km;
    data['address'] = address;
    data['order_opening_time'] = orderOpeningTime;
    data['order_closing_time'] = orderClosingTime;
    data['is_active'] = isActive;
    data['is_closed'] = isClosed;
    data['cover_image'] = coverImage;
    data['logo_image'] = logoImage;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
