import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Coordinator profile'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
        //background settings for profile pic
          Container(
            height: 200,
              decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("images/blood_doodle.jpg"),
              fit: BoxFit.cover,
              colorFilter: new ColorFilter.mode(
                  Colors.black.withOpacity(0.2), BlendMode.dstATop),),
                color: Colors.deepOrange.shade300,
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              //profile picture
                CircleAvatar(
                  minRadius: 60,
                  backgroundColor: Colors.deepOrange.shade300,
                  child: CircleAvatar(
                    backgroundImage: new AssetImage("images/profile.jpg"),
                    minRadius: 50,
                  ),
                ),
              ],
            ),
            //Name and profession details
            SizedBox(height: 10,),
            Text("Name", style: TextStyle(fontSize: 22.0, color: Colors.white,fontWeight: FontWeight.bold),),
            Text("Social Worker/Engineer", style: TextStyle(fontSize: 14.0, color: Colors.white),)
          ], ),
          ),
          
          Container(
            // height: 50,
            child: Row(
              children: <Widget>[
              //Experience details
                Expanded(
                  child: Container(
                    color: Colors.deepOrange.shade400,
                    child: ListTile(
                      title: Text("3 yrs",textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0
                      ),),
                      subtitle: Text("of trusted service", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70,
                      fontStyle: FontStyle.italic),),
                    ),
                  ),
                ),
                //Details of donors' verified
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: ListTile(
                      title: Text("100",textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0
                      ),),
                      subtitle: Text("verified donor requests", textAlign: TextAlign.center, style: TextStyle(color: Colors.white70,
                          fontStyle: FontStyle.italic),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          //Other details
          ListTile(
            title: Text("Coordinator ID", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text("ID001", style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("Phone", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text("123", style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("Email", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text("xyz.com", style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("Address", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text("abc", style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
        ],
      )
    );
  }
}
