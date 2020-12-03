import 'package:app_1/signup/home.dart';
import 'package:app_1/signup/signup.dart';
import 'package:app_1/splash_screen/splash.dart';
import 'package:flutter/material.dart';
import 'package:app_1/signup/description.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.blueGrey,
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      routes: {
        '/signIn' : (context) => SignUp(),
        '/home' : (context) => Home(),
        '/description' : (context) => Description(),
      },
    );
  }
}

