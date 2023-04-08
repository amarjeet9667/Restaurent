import 'package:flutter/material.dart';

import '../../util/colors.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: const Icon(
                Icons.menu,
                color: green,
              ),
            ),
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: green,
                ),
                Text(
                  "Gurugram, HR",
                  style: TextStyle(color: black, fontSize: 15),
                ),
              ],
            ),
            const Icon(
              Icons.person,
              color: green,
            )
          ],
        ),
      ],
    );
  }
}
