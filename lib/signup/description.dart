import 'dart:ui';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:app_1/model_class/details.dart';
import 'package:app_1/model_class/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_1/styles/style.dart';
import 'package:connectivity/connectivity.dart';
class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {

  String searchText = "";
  int people = 0;
  var connectivityResult;

  bool Add(String index,int id)
  {
    var i = id-1;
    for(var x in usersId[i])
      {
        if(x == index)
          {
            return true;
          }
      }
    return false;

  }
   dialog(String classId)
  {
    int id = int.parse(classId);

  return showDialog(context: context,
        builder: (context){
          return WillPopScope(
            onWillPop: () async {
              setState(() {
                print('search');
                searchText = '';
              });
              return true;
            },
            child: Padding(padding: EdgeInsets.all(8),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    decoration: BoxDecoration(
                     // borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    child: Material(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical : 10.0),
                                child: Text('Members' , style: TextS.style1,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical : 10.0),
                                child: Text('${usersId[id-1].length.toString()} people' ,),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical : 10.0),
                                child: IconButton(icon: Icon(Icons.cancel_rounded),onPressed: () {
                                  setState(() {
                                    searchText = "";
                                  });
                                  Navigator.pop(context);
                                },),
                              )
                            ],
                          ),
                          SizedBox(height: 7,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal : 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(color: Colors.grey,width: 1),
                              ),
                              child: TextField(
                                onChanged: (value){
                                  setState(() {
                                    searchText = value;
                                    print(searchText);
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: 'Search People',
                                  prefixIcon: Icon(Icons.search),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Expanded(
                            child: Container(
                                child: ListView.builder(
                                    itemCount: users.length,
                                    itemBuilder: (BuildContext context ,int index)
                                    {
                                      bool flag ;
                                      flag = Add(users[index].userId,id);
                                      if(searchText.isEmpty)
                                        {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width - 10,
                                              child: Row(
                                                //crossAxisAlignment:  CrossAxisAlignment.baseline,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(radius: 20,
                                                    child: ClipOval(
                                                      child: SizedBox(
                                                        height: 40,
                                                        width: 40,
                                                        child: Image(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(users[index].profilePic)
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                                    child: Container(
                                                        width: MediaQuery.of(context).size.width/1.9,
                                                        child: Text(users[index].userName,maxLines: 2,)),
                                                  ),

                                                 flag == true ? Container() : InkWell(
                                                     onTap: (){
                                                       setState(() {
                                                         usersId[id-1].insert(usersId[id-1].length , users[index].userId);
                                                         Navigator.pop(context);
                                                       });

                                                     },
                                                     child: Container(
                                                         decoration: BoxDecoration(
                                                           border: Border.all(color: Colors.blueGrey,width: 2)
                                                         ),
                                                         child: Padding(
                                                           padding: const EdgeInsets.all(3),
                                                           child: Text('Add'),
                                                         ))),
                                                  SizedBox(height: 5,)
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      else if(users[index].userName.startsWith(searchText))
                                        {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: MediaQuery.of(context).size.width - 10,
                                              child: Row(
                                                //crossAxisAlignment:  CrossAxisAlignment.baseline,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(radius: 20,
                                                    child: ClipOval(
                                                      child: SizedBox(
                                                        height: 40,
                                                        width: 40,
                                                        child: Image(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(users[index].profilePic)
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(10,0,0,0),
                                                    child: Container(
                                                        width: MediaQuery.of(context).size.width/1.9,
                                                        child: Text(users[index].userName)),
                                                  ),

                                                  flag == true ? Container() : InkWell(
                                                      onTap: (){
                                                        setState(() {
                                                          usersId[id-1].insert(usersId[id-1].length , users[index].userId);
                                                          Navigator.pop(context);
                                                          //usersId.insert(id-1, users[index].userId);
                                                        });
                                                        },
                                                      child: Container(
                                                          decoration: BoxDecoration(
                                                              border: Border.all(color: Colors.blueGrey,width: 2)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(3),
                                                            child: Text('Add'),
                                                          ))),
                                                  SizedBox(height: 5,)
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      else {
                                            return Container();
                                      }
                                    }
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: MediaQuery.of(context).size.height/1.9,
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  List<Detail> detail = new List<Detail>();
   List usersId = List();
   var response;
  Future<String> loadFile() async{
    return rootBundle.loadString('assets/class.json');
  }
  void getDetails() async{
    String file = await loadFile();

    response = jsonDecode(file);

    for(var x in response)
      {
           setState(() {
             detail.add(Detail.fromJson(x));
           });
      }

    detail.forEach((element) {
      usersId.add(element.signInUserId.toList());
    });

  }
  checkConnection() async{
    connectivityResult = await (Connectivity().checkConnectivity());
   }

   Future<String> LoadUsers() async{
    return rootBundle.loadString('assets/user.json');
   }

   var userResponse;
  List<User> users = List<User>();
   void getUsers() async{
    String file = await LoadUsers();
    userResponse = jsonDecode(file);

    for(var v in userResponse)
      {
        setState(() {
          users.add(User.fromJson(v));
        });
      }
   }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
    getUsers();
    checkConnection();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        connectivityResult = result;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    int i;
    setState(() {
      i = int.parse(data['classId']) -1;
    });
    print(usersId[i].length);
    return SafeArea(
      child: Scaffold(
        body: connectivityResult != ConnectivityResult.none ? Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3.9,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(data['classImage']),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(icon : Icon(Icons.arrow_back) , color:  Colors.white ,onPressed: (){
                      Navigator.pop(context);
                    },),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : 15.0,vertical: 5),
              child: Container(
                child: Row(
                  children: [
                    Text(data['className'],style: TextS.style1),
                    SizedBox(width: 3,),
                    Expanded(
                      child: Text(data['classType'],
                      style: TextS.style2
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : 15.0,vertical: 5),
              child: Container(
                child: Row(
                  children: [
                    Text('Coach ',style: TextS.style1),
                    SizedBox(width: 3,),
                    Text(data['coachName'],style: TextS.style2,),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal : 15.0,vertical: 5),
              child: Container(
                child: Row(
                  children: [
                    Text('Time ',style: TextS.style1),
                    SizedBox(width: 3,),
                    Text(data['classTiming'],style: TextS.style2,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                    dialog(data['classId']);
                    },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal : 15.0,vertical: 5),
                child: Container(
                  child: Row(
                    children: [
                      Text(usersId[i].length.toString()
                          ,style: TextS.style1),
                      SizedBox(width: 3,),
                      Text('People',
                        style: TextS.style2
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ) : Center(child: Container(child: TextS.netError,))
      ),
    );
  }
}
