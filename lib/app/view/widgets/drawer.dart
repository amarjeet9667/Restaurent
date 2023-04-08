import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/util/colors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.8,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          color: white,
          border: Border.all(
            color: green,
          )),
      child: Drawer(
        elevation: 0,
        backgroundColor: green.withOpacity(0.2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              margin: const EdgeInsets.only(bottom: 20),
              child: Row(
                children: const [
                  Text(
                    "Hi\nUser",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 50),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: white,
                    backgroundImage: NetworkImage(
                        "https://static.toiimg.com/thumb/msid-56833673,imgsize-141560,width-400,resizemode-4/56833673.jpg"),
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "LogOut",
                  style: TextStyle(
                      color: green.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }
}
