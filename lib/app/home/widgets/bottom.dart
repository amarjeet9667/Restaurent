import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/home/model/menu.dart';

import '../../common_colors/colors.dart';

class MyBottom extends StatefulWidget {
  final List<FoodType> tabs;
  const MyBottom({super.key, required this.tabs});

  @override
  State<MyBottom> createState() => _MyBottomState();
}

class _MyBottomState extends State<MyBottom> {
  int selectedIndex = 0;

  changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.tabs.length,
          itemBuilder: (context, index) {
            final name = widget.tabs[index].name;
            log(name);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  changeIndex(index);
                },
                child: Text(
                  name,
                  style: TextStyle(
                    color: selectedIndex == index ? green : black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
