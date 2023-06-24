import 'package:flutter/material.dart';

import '../../helper/constants.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: fireStore
            .collection('User')
            .doc(firebaseAuth.currentUser!.uid)
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            const CircularProgressIndicator();
          }
          final user = snapshot.data;
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
                  const Row(
                    children: [
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
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: white,
                    backgroundImage: user != null
                        ? NetworkImage(user.get('photo') ?? '') as ImageProvider
                        : const AssetImage('assets/user.png'),
                  ),
                ],
              ),
            ],
          );
        }));
  }
}
