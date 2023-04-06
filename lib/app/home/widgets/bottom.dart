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
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
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
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 5),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: currentIndex == index ? green : black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      if (index != widget.categories.length - 1)
                        const Icon(
                          Icons.circle,
                          size: 5,
                          color: black,
                        ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
