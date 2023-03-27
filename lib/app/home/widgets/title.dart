import 'package:flutter/material.dart';

import '../../common_colors/colors.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.menu,
          color: green,
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
    );
  }
}
