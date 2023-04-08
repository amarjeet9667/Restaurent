import 'package:flutter/material.dart';

class MyBottomState extends ChangeNotifier {
  int currentIndex = 0;

  int get currentIndexs => currentIndex;

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
