
import 'package:flutter/material.dart';
import 'package:revive/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart';
import 'login_activity.dart';
import 'utils.dart' as ut;
import 'package:carousel_pro/carousel_pro.dart';
import './newsfeed.dart';


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
    Widget image_carousel = new Container(
      height: 200,
      child: new Carousel(
        boxFit : BoxFit.cover,
        images: [
          AssetImage('assets/images/image7.jpeg'),
          AssetImage('assets/images/image5.jpg'),
          AssetImage('assets/images/image6.jpeg')
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 5.0,
      ),
    );
    return MaterialApp(
      title: 'Home',
      theme: ut.maintheme(),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
        //Hamburger menu
          endDrawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Center(
                      child:Text('Revive',
                        style: TextStyle(color:Colors.white,fontSize:50,fontWeight:FontWeight.bold),),),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/blood_doodle.jpg"),
                          fit: BoxFit.cover,
                          colorFilter: new ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.dstATop),),
                        color: Colors.redAccent
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Login'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.format_align_left),
                    title: Text("Donor's registration form"),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
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
                    leading: Icon(Icons.send),
                    title: Text('Request blood'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text('What and Why'),
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
                    leading: Icon(Icons.import_contacts),
                    title: Text('Terms and conditions'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text('Contact us'),
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
            SizedBox(
              height:400,
              child:ListView(
                children: <Widget>[
                  image_carousel    //calling the image slider inside body
                ],
        ),
      ),
            //Emergency requirements button
            Center(
              child:RaisedButton(    
                padding: const EdgeInsets.all(2.0),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(80.0),
                ),
                onPressed: () {
                  //Emergency requirements redirection code
                  //redirection to newsfeed.dart file
                },
                child:Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    gradient: LinearGradient(
                        colors: [Colors.orange,Colors.red]
                    ),
                  ),
                  height: 45,
                  width: 250,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text("Emergency requirements-->",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                ),),
              ),
                Padding(padding: EdgeInsets.all(10.0),),
            //Request donor button
                Center(
                  child:RaisedButton(
                    padding: const EdgeInsets.all(2.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(80.0),
                    ),
                    onPressed: () {
                      //Request donor redirection code
                    },
                      child:Container(
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        gradient: LinearGradient(
                            colors: [Colors.orange,Colors.red]
                        ),
                      ),
                       height: 45,
                       width: 250,
                          padding: const EdgeInsets.fromLTRB(60, 10, 50, 10),
                        child: Text("Request donor",
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
            ),),),
            //Login and signup button
            Expanded(child:Align(
              alignment: FractionalOffset.bottomCenter,
              child:Row(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    print("tapped");
                  },
                  child:Container(
                  width:180,
                    child:RaisedButton(
                      elevation: 5.0,
                      child: Text("Log in",
                  style: TextStyle(color:Colors.red),),
                  onPressed: (){
                    //Login redirection code
                    login();
                  },
                ),),),
                Container(
                  width:180,
                    child:RaisedButton(
                      child: Text("Sign up",
                    style: TextStyle(color:Colors.red),),
                  onPressed: (){
                    //Sign up redirection code
                    signup();
                  },
                ))
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
  login(){
    Navigator.push(context,
      MaterialPageRoute(builder: (context) =>
          LoginPage()),).then((var value) {
      //CODE HERE to execute if you back to this page from signup

    });
  }
}


