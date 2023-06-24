import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/provider/bottom_provider.dart';
import 'package:restaurent_test1/app/helper/constants.dart';
import 'package:restaurent_test1/app/view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51NLkXBSFN73JriRHPcrAsYFFOpxcKUzkc82EJLfPq7LfWbe9KalHlSPmZjn09eYM1biDaSzyXXBUo7koExZdJrsV00LBnZCWei';
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: trans));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyBottomState(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddButtonProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
