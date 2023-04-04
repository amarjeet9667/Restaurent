import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../common_colors/colors.dart';

class CustomFlexibleBar extends StatelessWidget {
  const CustomFlexibleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        margin: const EdgeInsets.only(top: 45),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hi Jeet",
              style: TextStyle(
                color: green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Find your food",
              style: TextStyle(
                color: black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: green.withOpacity(0.07)),
              child: TextField(
                style: const TextStyle(color: black),
                cursorColor: black,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search food ",
                    hintStyle: TextStyle(color: grey.withOpacity(0.5)),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: green,
                    ),
                    suffixIcon: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: green),
                      child: const Icon(
                        MdiIcons.tuneVerticalVariant,
                        color: white,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
