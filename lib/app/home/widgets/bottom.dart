import 'package:flutter/material.dart';

import '../../common_colors/colors.dart';

class MyBottom extends StatefulWidget {
  final List<String> tabs;
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
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  changeIndex(index);
                },
                child: Text(
                  widget.tabs[index],
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
