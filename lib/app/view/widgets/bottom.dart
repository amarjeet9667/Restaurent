import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/model/menu.dart';

import '../../helper/constants.dart';
import '../../provider/bottom_provider.dart';

class MyBottom extends StatefulWidget {
  final List<FoodType> categories;

  const MyBottom({
    super.key,
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
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.categories.length,
            itemBuilder: (context, index) {
              final name = widget.categories[index].name;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      myBottomState.updateIndex(index);
                    });
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 22),
                        child: Text(
                          name,
                          style: TextStyle(
                            color: currentIndex == index ? green : black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
