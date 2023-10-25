import 'dart:convert';

import 'package:shopping_with_us/models/category.dart';
import 'package:shopping_with_us/models/item.dart';

import 'data.dart';
import 'item_type.dart';

class DemoVendor {
  bool? status;
  Data? data;
  List<Category>? categories;
  Map<String, List<Item>>? highlightedItems;
  Map<String, List<Item>>? itemTypes;
  List<ItemType>? itemTypeLists;

  DemoVendor(
      {this.status,
      this.data,
      this.categories,
      this.highlightedItems,
      this.itemTypes,
      this.itemTypeLists});

  DemoVendor.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
      });
    }
    if (json['highlighted_items'] != null) {
      highlightedItems = {};
      (json['highlighted_items'] as Map<String, dynamic>).forEach((key, value) {
        highlightedItems![key] = List<Item>.from(
            (value as List<dynamic>).map((json) => Item.fromJson(json)));
      });
    }

    if (json['item_types'] != null) {
      itemTypes = {};
      (json['item_types'] as Map<String, dynamic>).forEach((key, value) {
        itemTypes![key] = List<Item>.from(
            (value as List<dynamic>).map((json) => Item.fromJson(json)));
      });
    }
    if (json['item_type_lists'] != null) {
      itemTypeLists = <ItemType>[];
      json['item_type_lists'].forEach((v) {
        itemTypeLists!.add(ItemType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (highlightedItems != null) {
      data['highlighted_items'] = jsonEncode(highlightedItems);
    }
    if (itemTypes != null) {
      data['item_types'] = jsonEncode(itemTypes);
    }
    if (itemTypeLists != null) {
      data['item_type_lists'] = itemTypeLists!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
