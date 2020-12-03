import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_1/model_class/user.dart';
import 'package:app_1/images/image.dart';
import 'package:app_1/signup/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  User user;
  dynamic iconVisible = Icon(Icons.remove_red_eye_outlined , color: Colors.grey,);
  dynamic iconObscure = Icon(Icons.visibility_off_outlined, color: Colors.grey,);
  bool obscure = true;
 // String iconType = 'visibility_off_outlined';
  String email , password;
  dynamic response;

  var snackBar = SnackBar(content: Text('Invalid Credentials !!',style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.deepOrange,duration: Duration(seconds: 3),
  );


  List<User> users = List<User>();
  Future<String> loadJson() async{
    return await rootBundle.loadString('assets/user.json');
  }

  Future<List<User>> addDetails() async{
    String jsonString = await loadJson();
   // print(jsonString);
    response = jsonDecode(jsonString);
    for (var user in response)
    {
      users.add(User.fromJson(user));
    }
   // print(users.length);
    return users;
  }

  bool checkAuth(String email)
  {
    for(var user in users)
      {
        if(user.email == email)
          {
            return true;
          }
      }
    return false;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     addDetails();
    //users.clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    users.clear();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Builder(
          builder: (BuildContext context) => Container(

            child: LimitedBox(
              maxHeight: MediaQuery.of(context).size.height,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical : 20.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image(image: AssetImage(SplashScreenImages.hash,) ,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal : 20 , vertical: 15),
                      child: Text('Sign Up',style: TextStyle(
                          fontSize: 25,fontWeight: FontWeight.bold,
                      ),),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height*(1/1.8),
                    ),
                    child:   Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal : 20.0 , vertical: 2),
                            child: TextFormField(
                              cursorColor: Colors.orangeAccent,
                              decoration: InputDecoration(

                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.deepOrange)
                                ),
                                labelText: 'E-mail Address',
                                labelStyle: TextStyle(
                                    color: Colors.grey
                                ),
                              ),
                              onChanged: (value){
                                setState(() {
                                  email = value;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal : 20.0 , vertical: 2),
                            child: TextFormField(
                              onChanged: (value){
                                password = value;
                              },

                              cursorColor: Colors.orangeAccent,
                              obscureText: obscure,
                              decoration: InputDecoration(

                                suffixIcon: obscure == true ? IconButton(icon: Icon(Icons.visibility_off_outlined),
                                    color: Colors.indigo,
                                    onPressed: (){
                                       setState(() {
                                         obscure = false;
                                       });
                                    }) : IconButton(icon: Icon(Icons.remove_red_eye_outlined),color: Colors.blue, onPressed: (){
                                      setState(() {
                                        obscure = true;
                                      });
                                    })   ,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.deepOrange)
                                ),
                                labelText: 'PassWord',
                                labelStyle: TextStyle(
                                    color: Colors.grey
                                ),
                              ),

                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text('Forgot Password ?' ,style:  TextStyle(color: Colors.blue),),),

                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: RaisedButton(onPressed: () async {
                        bool flag;
                        flag = checkAuth(email);
                        if(flag == true && password == 'Test@123')
                          {
                            SharedPreferences pref = await SharedPreferences.getInstance();
                            pref.setString('email', email);
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        else
                          {
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
                        },
                        color: Colors.blue,child: Text('Sign In',style:
                        TextStyle(color: Colors.white),),)),

                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: RaisedButton(onPressed: (){},child : Text('Create New Account'),))
                ],
              ),
            ),
          ),
        )

      ),
    );
  }
}
