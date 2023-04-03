import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/home/model/menu.dart';

import '../../common_colors/colors.dart';
import '../provider/bottom_provider.dart';

class MyBottom extends StatefulWidget {
  final List<String> name;
  final List<int> price;
  final List<FoodType> categories;

  const MyBottom({
    super.key,
    required this.name,
    required this.price,
    required this.categories,
  });

  @override
  State<MyBottom> createState() => _MyBottomState();
}

class _MyBottomState extends State<MyBottom> {
  @override
  Widget build(BuildContext context) {
    final myBottomState = Provider.of<MyBottomState>(context);
    final currentIndex = myBottomState.currentIndex;

    return SizedBox(
      height: 30,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: widget.categories.length,
          itemBuilder: (context, index) {
            final name = widget.categories[index].name;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    myBottomState.updateIndex(index);
                  });
                },
                child: Text(
                  name,
                  style: TextStyle(
                    color: currentIndex == index ? green : black,
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
