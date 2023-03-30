import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  int increase = 1;
  int get increaseNum => increase;

  void itemIncreses() {
    increase++;
    notifyListeners();
  }
}
  