import 'dart:convert';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:koukicons/assistant.dart';
import 'package:revive/about.dart';
import 'package:revive/blood_banks.dart';
import 'package:revive/choose_group.dart';
import 'package:revive/coordinator_login.dart';
import 'package:revive/coordinator_profile.dart';
import 'package:revive/coordinator_requests_list.dart';
import 'package:revive/coordinators%20list.dart';
import 'package:revive/deleteimage.dart';
import 'package:revive/donor%20search%20page.dart';
import 'package:revive/faq.dart';
import 'package:revive/newsfeed.dart';
import 'package:revive/profile.dart';
import 'package:revive/request.dart';
import 'package:revive/signup.dart';
import 'package:revive/terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addimage.dart';
import 'globals.dart' as g;
import 'login_activity.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'pushnotifications.dart';
import 'mobileverification.dart';
import 'package:mongo_dart/mongo_dart.dart' as mon;

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;
  bool imageloading = true;
  List images=[];
  List imagewidgets=[];
  String photoupload;
  asyncFunc(BuildContext) async {
    await setPrefs();
    await coordinatorsetPrefs();
    await initmon();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }

  void start(BuildContext) {
    asyncFunc(BuildContext);
  }
     mon.Db db;
  initmon() async {
    db = new mon.Db(g.mongo_url);
    await db.open().then((val){print("$val");});
    loadimages();
  }
  void addtolist(Map a){
    setState(() {
      imagewidgets.add(a['image']);
      var b = Image.memory(base64Decode(a['image']),fit: BoxFit.fill,);
      images.add(b);
    });
    
  }
  loadimages() async{
   
   var gallery = db.collection("gallery");
   await gallery.find().forEach(addtolist).then((onValue){print(onValue);
    setState(() {
      imageloading = false;
    });
    });   
  }

  @override
  void dispose() {
    super.dispose();
  }

Widget image_carouselhome() => Container(
  height: 200,
  child:  new Carousel(
    boxFit : BoxFit.fitWidth,
    images: images,
    autoplay: true,
    overlayShadowColors: Colors.white,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),
    dotSize: 4.0,
    dotBgColor: Colors.transparent,
    indicatorBgPadding: 10.0,
  ),
);
  @override
  Widget build(BuildContext context) {
    //Image slider

    return MaterialApp(
      title: 'Home',
      theme: ut.maintheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Revive'),
          centerTitle: true,
          actions: <Widget>[
            InkWell(
              child: Row(
                children: <Widget>[
                  Icon(Icons.notifications),
                  SizedBox(
                    width: 15,
                  ),
                  g.g_l.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.account_circle,
                            size: 25,
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoordinatorProfile())),
                        )
                      : g.g_bg.isNotEmpty
                          ? IconButton(
                              icon: Icon(
                                Icons.account_circle,
                                size: 25,
                              ),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profile())),
                            )
                          : SizedBox(
                              height: 1,
                            ),
                            photoupload == "1" ?
                             IconButton(icon: Icon(Icons.add_a_photo), onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=> Addimage()));
                            }): SizedBox(
                              height: 1,
                            ),
                            photoupload == "1" ? 
                            IconButton(icon: Icon(Icons.delete), onPressed:() 
                            
                            { Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteImage(images:imagewidgets) ));})
                            : SizedBox(
                              height: 1,
                            )
                ],
              ),
            ),
          ],
        ),
        //Hamburger menu
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Revive',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500),
                      ),
                      ut.caption()
                    ]),
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/logo.png"),
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.1), BlendMode.dstATop),
                  ),
                  color: Colors.redAccent),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search donor'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DonorSearch()));
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('List of blood banks'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BloodBanks()));
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('List of coordinators'),
              onTap: () {
                 Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CoordinatorsList()));
              },
            ),
            g.g_bg.isNotEmpty
                ? ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profile()));
                      // Update the state of the app.
                      // ...
                    },
                  )
                : (g.g_l.isNotEmpty
                    ? ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text('Profile'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CoordinatorProfile()));
                          // Update the state of the app.
                          // ...
                        },
                      )
                    : SizedBox(width: 1)),
            g.g_l.isNotEmpty
                ? ListTile(
                    leading: Icon(Icons.list),
                    title: Text('Request List'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RequestList()));
                      // Update the state of the app.
                      // ...
                    },
                  )
                : SizedBox(width: 1),
            g.g_l.isNotEmpty||g.g_bg.isNotEmpty
                ? ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text('Log out'),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      final SharedPreferences sp =
                                          await SharedPreferences.getInstance();
                                      sp.setString('name', '');
                                      sp.setString('username', '');
                                      sp.setString('blood_group', '');
                                      sp.setString('password', '');
                                      sp.setString('location', '');
                                      sp.setString("gender", '');
                                      sp.setString("district", '');
                                      sp.setString("age", '');
                                      sp.setString("weight", '');
                                      sp.setString("taluk", '');
                                      sp.setString("contacts", '');
                                      sp.setString("alt_contact", '');
                                      sp.setString("email", '');
                                      sp.setString("last_don", '');
                                      sp.setString("status", '');
                                      sp.setString("for_time", '');
                                      sp.setString("photo_upload", "");
                                      setState(() {
                                        g.g_n = '';
                                        g.g_bg = '';
                                        g.g_l = '';
                                        photoupload='';
                                      });
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFEE5623)),
                                    )),
                                FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFEE5623)),
                                    ))
                              ],
                              content: Text(
                                "Do you want to log out?",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFFEE5623)),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              contentPadding: EdgeInsets.all(20),
                            );
                          });
                      // Update the state of the app.
                      // ...
                    },
                  )
                : SizedBox(width: 1),
            g.g_bg.isNotEmpty
                ? ListTile(
                    title: Text('Delete Account'),
                    leading: Icon(Icons.delete),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              actions: <Widget>[
                                FlatButton(
                                    onPressed: () async {
                                      final SharedPreferences sp =
                                          await SharedPreferences.getInstance();
                                      String uname = sp.getString("username");
                                      var bd = jsonEncode({"username": uname});
                                      var result = await http.post(
                                          g.baseUrl + "/delete_account.php",
                                          body: bd);
                                      Navigator.pop(context);
                                      ut.showtoast(
                                          jsonDecode(result.body), Colors.red);
                                      sp.setString('name', '');
                                      sp.setString('username', '');
                                      sp.setString('blood_group', '');
                                      sp.setString('password', '');
                                      sp.setString('location', '');
                                      sp.setString("gender", '');
                                      sp.setString("district", '');
                                      sp.setString("age", '');
                                      sp.setString("weight", '');
                                      sp.setString("taluk", '');
                                      sp.setString("contacts", '');
                                      sp.setString("alt_contact", '');
                                      sp.setString("email", '');
                                      sp.setString("last_don", '');
                                      sp.setString("status", '');
                                      sp.setString("for_time", '');
                                      setState(() {
                                        g.g_n = '';
                                        g.g_bg = '';
                                        g.g_l = '';
                                      });
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFEE5623)),
                                    )),
                                FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xFFEE5623)),
                                    ))
                              ],
                              content: Text(
                                "Do you want to delete account?",
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFFEE5623)),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              contentPadding: EdgeInsets.all(20),
                            );
                          });
                    },
                  )
                : SizedBox(
                    width: 1,
                  ),
                  ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('FAQs'),
              onTap: () {
               Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Faq()),
    ).then((var value) {
      //CODE HERE to execute if you back to this page from signup
    });
              },
            ),
            ListTile(
              leading: Icon(Icons.import_contacts),
              title: Text('Terms and conditions'),
              onTap: () {
                terms();
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About us'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => About()));
                // Update the state of the app.
                // ...
              },
            ),
          ],
        )),
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      height:250,
                      child: imageloading? Padding(
                        padding: const EdgeInsets.all(110.0),
                        child: CircularProgressIndicator(),
                      ) : images.length == 0? ut.empty_server("No images to show") : image_carouselhome(),
                    ),
                    ut.banner(),
                    if(g.g_l.isEmpty)SizedBox(height: 20,),


                    if(g.g_l.isNotEmpty || g.g_bg.isNotEmpty)InkWell(
                      onTap: () {bloodrequest();},
                      child: ut.mainbutton("Request blood")
                    ),
                    //Login and signup button
                    Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(child:Container(
                              padding: EdgeInsets.only(left: 20),

                              child:Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[

                             g.g_l.isNotEmpty||g.g_bg.isNotEmpty?SizedBox(width:2):InkWell(child:Row(children: <Widget>[

                                Text("User Login",
                                  style: TextStyle(fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 20),),
                                ut.
                                roundicon(Icons.keyboard_arrow_right,
                                    Colors.white, Colors.black,
                                    25, 0)
                              ],),onTap: (){login();},),
                               SizedBox(width: 10,),

                                g.g_l.isNotEmpty||g.g_bg.isNotEmpty?SizedBox(width:2): InkWell(child:Column(children: <Widget>[
//                                  Text("New user? ",
//                                      style: TextStyle(fontWeight: FontWeight.w400,
//                                      color: Colors.grey[600],
//                                      fontSize: 18)),
                                 Row(children: <Widget>[
                                    Text("Register here",
                                      style: TextStyle(fontWeight: FontWeight.w400,
                                          color: Colors.blue,
                                          fontSize: 18)),
                                  ut.
                                  roundicon(Icons.keyboard_arrow_right,
                                      Colors.white, Colors.blue,
                                      25, 0)
                                 ],)
                                ],),onTap: (){signup();},),
                            ],),)),

                            /*g.g_n.isEmpty
                                ? InkWell(
                                        onTap: () {
                                          signup();
                                        },
                                        child: ut.iconbutton("User signup",
                                            Icons.person,Colors.white))
                                : SizedBox(width: 1),*/

                            SizedBox(width: 20,)
                          ],
                    ),
                    SizedBox(height: 20,),
                    g.g_l.isNotEmpty||g.g_bg.isNotEmpty?SizedBox(width:2):Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        g.g_n.isEmpty
                            ? InkWell(
                            onTap: () {
                              coordinatorLogin();
                            },
                            child: ut.iconbutton("Coordinator login",
                                KoukiconsAssistant(height: 25,))
                        )
                            : SizedBox(width: 1),
                      ],
                    ),
                    SizedBox(height: 30,),
                    InkWell(
                        onTap: () {
                          newsfeed(true);
                        },
                        child: ut.mainbutton("Request feed")
                    ),
                    Expanded(child: Container(),),

                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MobileVerfication()),
    ).then((var value) {
      setPrefs();
      //CODE HERE to execute if you back to this page from signup
    });
  }

  coordinatorLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CoordinatorLoginPage()),
    ).then((var value) {
      coordinatorsetPrefs();
    });
  }

  terms() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Terms()),
    ).then((var value) {
      //CODE HERE to execute if you back to this page from signup
    });
  }

  login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    ).then((var value) {
      setPrefs();
      //CODE HERE to execute if you back to this page from signup
    });
  }
  newsfeed(bool emergency){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChooseGroup(emergency: emergency,)));
  }
  bloodrequest(){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BloodRequest()));
  }
  setPrefs() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      g.g_n = sp.get("name");
      g.g_bg = sp.get("blood_group");
      if (g.g_n == null || g.g_bg == null) {
        g.g_n = '';
        g.g_bg = '';
      }
    });
  }

  coordinatorsetPrefs() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      g.g_n = sp.get("name");
      g.g_l = sp.get("location");
      photoupload = sp.get("photo_upload");
      if (g.g_n == null || g.g_l == null) {
        g.g_n = '';
        g.g_l = '';
      }
    });
  }
}