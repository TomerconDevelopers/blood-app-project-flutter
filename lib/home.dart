import 'package:flutter/material.dart';
import 'package:revive/about.dart';
import 'package:revive/blood_banks.dart';
import 'package:revive/coordinator_profile.dart';
import 'package:revive/newsfeed.dart';
import 'package:revive/profile.dart';
import 'package:revive/request.dart';
import 'package:revive/signup.dart';
import 'package:revive/terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as g;
import 'login_activity.dart';
import 'utils.dart' as ut;

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;
  
  asyncFunc(BuildContext) async {
    await setPrefs();
    
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }

  void start(BuildContext) {
    asyncFunc(BuildContext);
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                  SizedBox(width: 15,),
              g.n.isNotEmpty?IconButton(icon:Icon(Icons.account_circle,size:25,),onPressed:()=> Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>Profile())),):SizedBox(height: 1,),
            
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
                // Update the state of the app.
                // ...
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
                // Update the state of the app.
                // ...
              },
            ),
            g.n.isNotEmpty?ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) =>Profile()));
                // Update the state of the app.
                // ...
              },
            ):SizedBox(width:1)
            ,g.n.isNotEmpty?ListTile(
              leading: Icon(Icons.power_settings_new),
              title: Text('Log out'),
              onTap: () {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: <Widget>[
                FlatButton(onPressed:()async{
                  final SharedPreferences sp=await SharedPreferences.getInstance();
                      sp.setString('name','');
                      sp.setString('username','');
                      sp.setString('blood_group','');
                      sp.setString('password','');
                    setState((){                     
                      g.n='';
                      g.bg='';
                    });
                    Navigator.pop(context);
                }, child:Text('Yes',style: TextStyle(fontSize: 20, color: Color(0xFFEE5623)),)),
                FlatButton(onPressed:()=>Navigator.pop(context), child: Text('Cancel',style: TextStyle(fontSize: 15, color: Color(0xFFEE5623)),))
              ],
              content: Text(
                "Do you want to log out?",
                style: TextStyle(fontSize: 20, color: Color(0xFFEE5623)),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              contentPadding: EdgeInsets.all(20),
            );
          });
                // Update the state of the app.
                // ...
              },
            ):SizedBox(width:1),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 400,
              child: ut.image_carousel(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "WELCOME " + g.n.toUpperCase(),
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFEE5623),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20,),
            //Emergency requirements button
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewsFeed()));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: ut.buttonstyle(),
                width: 250,
                child: Text(
                  "Emergency requirements",
                  style: ut.bt(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BloodRequest()));

                //Request donor redirection code
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: ut.buttonstyle(),
                width: 250,
                child: Text(
                  "Request blood",
                  style: ut.bt(),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
           
            //Login and signup button
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    g.n.isEmpty?InkWell(
                      onTap: () {
                        login();
                      },
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              ut.btext("Login"),
                              ut.roundicon(
                                  Icons.keyboard_arrow_right,
                                  Colors.white,
                                  Colors.deepOrange.shade300,
                                  20,
                                  0)
                            ],
                          )),
                    ):SizedBox(width:1),g.n.isEmpty?InkWell(
                      onTap: () {
                        signup();
                      },
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              ut.btext("Sign Up"),
                              ut.roundicon(Icons.list, Colors.white,
                                  Colors.deepOrange.shade300, 20, 0)
                            ],
                          )),
                    ):SizedBox(width:1)
                    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUp()),
    ).then((var value) {

      setPrefs();
      //CODE HERE to execute if you back to this page from signup
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
  setPrefs()async{
final SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      g.n = sp.get("name");
      g.bg = sp.get("blood_group");
      if(g.n==null){
      g.n='';
      g.bg='';
    }
    });
  }
  
}
