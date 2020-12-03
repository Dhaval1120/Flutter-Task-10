import 'package:flutter/material.dart';
import 'package:app_1/images/image.dart';
import 'package:app_1/signup/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> routePage()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.getString('email')==null)
      {
        return false;
      }
    else
      {
        return true;
      }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    routePage().then((value){
      if(!value)
        {
          Timer(
              Duration(
                  seconds: 3
              ), () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()))
          );
        }
      else
        {
          Timer(
              Duration(
                  seconds: 3
              ), () => Navigator.pushReplacementNamed(context, '/home')
          );

        }
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(SplashScreenImages.hash),
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.height/2,
            ),
            Expanded(
              child: Container(
                child: Image(
                  image: AssetImage(SplashScreenImages.image_1),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                ),
              ),
            )
          ],
        ) ,
      ),
    );
  }
}


