import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurent_test1/app/home/provider/addbutton_provider.dart';
import 'package:restaurent_test1/app/home/provider/bottom_provider.dart';
import 'package:restaurent_test1/app/splash_screen/splash_screen.dart';

import 'app/common_colors/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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
      const SystemUiOverlayStyle(statusBarColor: trans),
    );
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
