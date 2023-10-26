import 'package:shopping_with_us/models/item.dart';

import 'data.dart';

class ProductDetail {
  bool? status;
  String? message;
  Data? data;
  List<Item>? relatedItems;

  ProductDetail({this.status, this.message, this.data, this.relatedItems});

  ProductDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['related_items'] != null) {
      relatedItems = <Item>[];
      json['related_items'].forEach((v) {
        relatedItems!.add(Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (relatedItems != null) {
      data['related_items'] = relatedItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
