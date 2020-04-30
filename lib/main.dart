import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:revive/notify.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;
import 'home.dart';
import 'intro.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'globals.dart' as g;
void main() {
  //asyncFunc();
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Splash(),
    debugShowCheckedModeBanner: false,
    
  ));
}

SharedPreferences prefs;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=new FlutterLocalNotificationsPlugin();
asyncFunc(BuildContext) async {
  // Async func to handle Futures easier; or use Future.then
  prefs = await SharedPreferences.getInstance();
  var frun = prefs.getBool("frun");
  if (frun == true) {
    //Navigate to home
    Navigator.pushReplacement(
      BuildContext,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  } else {
    //Navigate to Intro
    Navigator.pushReplacement(
      BuildContext,
      MaterialPageRoute(builder: (context) => Intro()),
    );
  }
}

class Splash extends StatefulWidget {
  //HomeScreen({Key key}) : super(key: key);

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher'); 
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
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
    return MaterialApp(
        title: 'Student Login',
        theme: ut.maintheme(),
        home: Scaffold(
            /*appBar: AppBar(
              title: Text("Splash"),
            ),*/

            body: Container(decoration: ut.bg())));
  }
  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
          actions: <Widget>[
            FlatButton(onPressed: ()async{
              var bd=jsonEncode({"contacts":payload});
               var res=await http.post("http://192.168.111.2/blood-app-project-backend-master/del_emergency.php",body:bd);
                var reg=jsonDecode(res.body);
                if(res.statusCode==200){
                  ut.showtoast(reg, Colors.green);
                }
           
            }, child:Text('Yes')),
            FlatButton(onPressed: ()async{
              var bd=jsonEncode({"contacts":payload});
               var res=await http.post("http://192.168.111.2/blood-app-project-backend-master/del_emergency.php",body:bd);
                var reg=jsonDecode(res.body);
                if(res.statusCode==200){
                  ut.showtoast(reg, Colors.green);
                }
           
            }, child:Text('No')),
          ],
        );
      },
    );
  }
}
