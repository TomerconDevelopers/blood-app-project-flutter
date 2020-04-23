import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:revive/about.dart';
import 'package:revive/blood_banks.dart';
import 'package:revive/coordinator_login.dart';
import 'package:revive/coordinator_profile.dart';
import 'package:revive/coordinator_requests_list.dart';
import 'package:revive/newsfeed.dart';
import 'package:revive/profile.dart';
import 'package:revive/request.dart';
import 'package:revive/signup.dart';
import 'package:revive/terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as g;
import 'login_activity.dart';
import 'utils.dart' as ut;
import 'package:mongo_dart/mongo_dart.dart' as mon;
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => new HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;

  asyncFunc(BuildContext) async {
    await setPrefs();
    await coordinatorsetPrefs();
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
            g.g_n.isNotEmpty
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
                                      setState(() {
                                        g.g_n = '';
                                        g.g_bg = '';
                                        g.g_l = '';
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
                      height: 400,
                      child: ut.image_carousel(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "WELCOME " + g.g_n.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFEE5623),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    //Emergency requirements button
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NewsFeed()));
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BloodRequest()));

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
                    SizedBox(
                      height: 20,
                    ),
                    //Login and signup button
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            g.g_n.isEmpty
                                ? Container(
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 30),
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [Colors.orange, Colors.red]),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          login();
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              "User Login",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                  )
                                : SizedBox(width: 1),
                            g.g_n.isEmpty
                                ? Container(
                                    padding:
                                        EdgeInsets.only(top: 30, bottom: 30),
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [Colors.orange, Colors.red]),
                                    ),
                                    child: InkWell(
                                        onTap: () {
                                          signup();
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ],
                                        )),
                                  )
                                : SizedBox(width: 1),
                            g.g_n.isEmpty
                                ? Container(
                                    padding: EdgeInsets.only(top: 30, left: 8),
                                    height: 120,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      gradient: LinearGradient(
                                          colors: [Colors.orange, Colors.red]),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        coordinatorLogin();
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              "Coordinator Login",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(width: 1),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20)
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
      MaterialPageRoute(builder: (context) => SignUp()),
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
      if (g.g_n == null || g.g_l == null) {
        g.g_n = '';
        g.g_l = '';
      }
    });
  }
}
