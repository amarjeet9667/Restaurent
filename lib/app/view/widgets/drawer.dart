import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/util/colors.dart';
import 'package:restaurent_test1/app/view/screens/login_screen/login_view.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
    required this.height,
  });

  final double height;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isLogOut = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.8,
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
            isLogOut
                ? const Center(
                    child: CircularProgressIndicator(color: green),
                  )
                : TextButton(
                    onPressed: () async {
                      setState(() {
                        isLogOut = true;
                      });
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginView()),
                          (route) => false);
                      setState(() {
                        isLogOut = false;
                      });
                    },
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
