import 'package:flutter/material.dart';

class AddButtonProvider extends ChangeNotifier {
  Map<String, int> cart = {};
  Map<String, int> quantity = {};
  int cartAmount = 0;

  addItem(String key, int value) {
    cart.addAll({key: value});
    quantity.addAll({key: 1});
    cartAmount += value;
    notifyListeners();
  }

  removeItem(String key, int value) {
    cartAmount -= value;
    cart.removeWhere((k, v) => k == key);
    quantity.removeWhere((k, v) => k == key);
    notifyListeners();
  }

  increaseQuantity(String key, int value) {
    cart.update(key, (v) => value);
    quantity.update(key, (v) => ++v);
    cartAmount += value;
    notifyListeners();
  }

  decreaseQuantity(String key, int value) {
    cart.update(key, (v) => value);
    quantity.update(key, (v) => --v);
    cartAmount -= value;
    notifyListeners();
  }
}
