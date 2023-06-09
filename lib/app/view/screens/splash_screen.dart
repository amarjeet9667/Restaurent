import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/helper/constants.dart';
import 'package:restaurent_test1/app/provider/provider_splash.dart';
import 'package:restaurent_test1/app/view/screens/login_screen/login_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginView()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderSplash(),
      child: Container(
        color: white,
        child: Center(
          child: Image.asset(
            "assets/food.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
