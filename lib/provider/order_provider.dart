import 'package:flutter/material.dart';

import '../models/item.dart';

class OrderProvider with ChangeNotifier {
  // List<Item> _shoppingCartItems = [];
  // List<Item> get shoppingCartItems => _shoppingCartItems;

  // set shoppingCartItems(List<Item> shoppingCartItems) {
  //   _shoppingCartItems = shoppingCartItems;
  //   notifyListeners();
  // }

  Map<String, Item> _shoppingCartItems = {};
  Map<String, Item> get shoppingCartItems => _shoppingCartItems;

  set shoppingCartItems(Map<String, Item> shoppingCartItems) {
    _shoppingCartItems = shoppingCartItems;
    notifyListeners();
  }

  notify() {
    notifyListeners();
  }

  resetOrderProvider() {
    _shoppingCartItems = {};
    notifyListeners();
  }
}
