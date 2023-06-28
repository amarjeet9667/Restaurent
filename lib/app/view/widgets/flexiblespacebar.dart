import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../helper/constants.dart';

class CustomFlexibleBar extends StatelessWidget {
  const CustomFlexibleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: Container(
        margin: const EdgeInsets.only(top: 35),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 67),
        child: StreamBuilder(
            stream: fireStore
                .collection('User')
                .doc(firebaseAuth.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final user = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi ${user.get('name') ?? const Text('User')}",
                    style: const TextStyle(
                      color: green,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Find your food",
                    style: TextStyle(
                      color: black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
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
                            child: Icon(
                              MdiIcons.tuneVerticalVariant,
                              color: white,
                            ),
                          )),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
