import 'package:flutter/material.dart';
import 'package:restaurent_test1/app/util/colors.dart';
import 'package:restaurent_test1/app/util/login_buttons.dart';
import 'package:restaurent_test1/app/view/screens/login_screen/login_view.dart';
import 'package:restaurent_test1/app/view/screens/login_screen/signup_view.dart';

class LoginHome extends StatefulWidget {
  const LoginHome({super.key});

  @override
  State<LoginHome> createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        decoration: const BoxDecoration(
          color: white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  "Welcome Sir",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${String.fromCharCode(0x1F60B)} FUN FOOD',
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Image.asset(
              "assets/login.png",
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Buttons(
                    buttonText: "LOG IN",
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => const LoginView(),
                        ),
                      );
                    }),
                const SizedBox(height: 30),
                Buttons(
                    buttonText: "SIGN UP",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const SignUpView()));
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
