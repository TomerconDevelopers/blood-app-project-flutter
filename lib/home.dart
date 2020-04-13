
import 'package:flutter/material.dart';
import 'package:revive/signup.dart';
import 'package:revive/terms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';
import 'login_activity.dart';
import 'utils.dart' as ut;

class HomeScreen extends StatefulWidget {

  @override
  HomeScreenState createState() => new HomeScreenState();
}
class HomeScreenState extends State<HomeScreen> {
  SharedPreferences prefs;
  asyncFunc(BuildContext) async {

  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }
  void start(BuildContext){
    asyncFunc(BuildContext);
  }
  @override void dispose() {super.dispose();}
  @override
  Widget build(BuildContext context) {
    //Image slider

    return MaterialApp(
      title: 'Home',
      theme: ut.maintheme(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Revive'),

            actions: <Widget>[
              InkWell(child: Icon(Icons.notifications),)
            ],
          ),
        //Hamburger menu
          drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                      child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[Text('Revive',
                        style: TextStyle(color:Colors.white,fontSize:30,
                            fontWeight:FontWeight.w500),),
                        ut.caption()
                          ]
                      ),
          ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/logo.png"),
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.1), BlendMode.dstATop),),
                        color: Colors.redAccent
                    ),
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
                  ListTile(
                    leading: Icon(Icons.import_contacts),
                    title: Text('Terms and conditions'),
                    onTap: () {terms();},
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('About us'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                ],
              )
          ),
          body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20),
            height:400,
            child:ut.image_carousel(),
            ),
            //Emergency requirements button
      InkWell(
        onTap: () {
          //Request donor redirection code
        },
        child:Container(
          padding: EdgeInsets.all(10),
          decoration: ut.buttonstyle(),
          width: 250,
          child: Text("Emergency requirements",
            style: ut.bt(),
            textAlign: TextAlign.center,),
        ),),
                Padding(padding: EdgeInsets.all(10.0),),
                  InkWell(
                    onTap: () {
                      //Request donor redirection code
                    },
                      child:Container(
                        padding: EdgeInsets.all(10),
                       decoration: ut.buttonstyle(),
                       width: 250,
                        child: Text("Request donor",
                        style: ut.bt(),
                        textAlign: TextAlign.center,),
            ),),
            //Login and signup button
            Expanded(child:Align(
              alignment: FractionalOffset.bottomCenter,
              child:Row(
                mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                InkWell(
                  onTap: (){login();},
                  child:Container(
                      padding: EdgeInsets.all(20),
                      child:
                      Row(
                        children: <Widget>[
                          ut.btext("Login"),
                          ut.roundicon(Icons.keyboard_arrow_right, Colors.grey[700], Colors.grey[300], 20, 5)
                        ],
                      )
                  ),),
                InkWell(
                  onTap: (){signup();},
                  child:Container(
                    padding: EdgeInsets.all(20),
                    child:
                        Row(
                          children: <Widget>[
                            ut.btext("Signup"),
                            ut.roundicon(Icons.list, Colors.grey[700],
                                Colors.grey[300], 20, 5)
                          ],
                        )
                  ),),
              ],
            ),),)
          ],
        ),
      ),
    );
  }
  signup(){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
          SignUp()),).then((var value) {
            //CODE HERE to execute if you back to this page from signup

    });
  }
  terms(){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
         Terms()),).then((var value) {
      //CODE HERE to execute if you back to this page from signup

    });
  }
  login(){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
          LoginPage()),).then((var value) {
      //CODE HERE to execute if you back to this page from signup

    });
  }
}


