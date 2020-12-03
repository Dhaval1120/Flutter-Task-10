import 'dart:convert';
import 'package:app_1/styles/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_1/model_class/details.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_1/images/image.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var response;
  List<Detail> details = List<Detail>();

  Future<String> loadFile() async{
    return rootBundle.loadString('assets/class.json');
  }
  void getDetails() async{
    String file = await loadFile();
    response = jsonDecode(file);
    for(var x in response)
      {
        setState(() {
          details.add(Detail.fromJson(x));
        });
      }
  }

  var connectivityResult;
  checkConnection() async{
    connectivityResult = await (Connectivity().checkConnectivity());
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnection();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
    });
    getDetails();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body :  CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              //snap: true,
              backgroundColor: Colors.orangeAccent,
              expandedHeight: MediaQuery.of(context).size.height/3.9,
              flexibleSpace: FlexibleSpaceBar(
                title: Align(alignment: Alignment.bottomRight ,child: InkWell(
                    onTap: () async{
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      pref.remove('email');
                      Navigator.pushReplacementNamed(context, '/signIn');
                    },
                    child: Text('LogOut' , style: TextS.style1,))),
                background: Container(
                  height: MediaQuery.of(context).size.height/3.9,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage(HomeScreenImages.pic_1),
                    fit: BoxFit.cover,
                  ),
                ),
               ),
            ),

           SliverToBoxAdapter(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal : 15,vertical: 10),
               child: Container(child: Text('Available Classes' , style: TextS.style1,)),
             ),
           ),
           SliverList(delegate: SliverChildBuilderDelegate(
                     (context, index) => InkWell(
                       onTap: (){
                         Navigator.pushNamed(context, '/description' ,arguments: {
                           'className' : details[index].className,
                           'classId' : details[index].classId.substring(2),
                           'classImage' : details[index].classImage,
                           'classTiming' : details[index].classTiming,
                           'coachName' : details[index].coachName,
                           'classType' : details[index].classType,
                           'people' : 3
                         }
                         );
                       },
                       child: Padding(
                         padding: const EdgeInsets.symmetric(horizontal : 15.0,vertical: 10),
                         child: Container(
                           decoration: BoxDecoration(
                               border: Border.all(color: Colors.grey,width: 1),
                               borderRadius: BorderRadius.circular(3)
                           ),
                           height: MediaQuery.of(context).size.height/7,
                           width: MediaQuery.of(context).size.width,
                           child: Row(
                             children: [
                               Padding(padding: EdgeInsets.symmetric(horizontal: 8 , vertical: 2),
                                 child: CircleAvatar(
                                   backgroundColor: Colors.white,
                                   radius: 20 ,
                                   child: ClipOval(
                                     child: SizedBox(
                                         height: 40,
                                         width: 40,
                                         child: Image(
                                           image: NetworkImage(details[index].classImage),
                                           fit: BoxFit.cover,
                                         )
                                     ),
                                   ),
                                 ),
                               ),

                               SizedBox(width: 5,),

                               Container(
                                 width: MediaQuery.of(context).size.width/1.999,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: [
                                     Text(details[index].className),
                                     Text(details[index].coachName),
                                     Text(details[index].classTiming),
                                     Text(details[index].signInUserId.length.toString() + " People ")
                                   ],

                                 ),
                               ),

                               Flexible(
                                 child: Align(
                                   alignment: Alignment.topRight,
                                   child: Container(
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Text(details[index].classType,
                                         softWrap: true,
                                         overflow: TextOverflow.ellipsis,
                                         maxLines: 2,
                                       ),
                                     ),
                                   ),
                                 ),
                               )
                             ],
                           ),
                         ),
                       ),
                     ),
                 childCount: details.length,
               ),
             )
          ],
        )
      ),
    );
  }
}
