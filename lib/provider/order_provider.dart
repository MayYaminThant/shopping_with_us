import 'package:flutter/material.dart';
import 'package:shopping_with_us/models/data.dart';

import '../models/item.dart';

class OrderProvider with ChangeNotifier {
  Data? _userData;
  Data? get userData => _userData;

  set userData(Data? userData) {
    if (_userData == userData) return;
    _userData = userData;
    notifyListeners();
  }

  Map<String, Item> _shoppingCartItems = {};
  Map<String, Item> get shoppingCartItems => _shoppingCartItems;

  set shoppingCartItems(Map<String, Item> shoppingCartItems) {
    _shoppingCartItems = shoppingCartItems;
    notifyListeners();
  }

  double getSubTotal() {
    double subTotal = 0;
    for (Item item in _shoppingCartItems.values) {
      subTotal += ((item.qty ?? 0) * (item.price ?? 0));
    }
    return subTotal;
  }

  notify() {
    notifyListeners();
  }

  resetOrderProvider() {
    _userData = null;
    _shoppingCartItems = {};
    notifyListeners();
  }
}
