import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart' as g;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map f={};
  String u=g.baseurl;
  @override
  void initState() {
    postValues();
    super.initState();
  }
  String uname = '';
  var r;
  String n = '',
      pr='',
      d = '',
      l = '',
      c = '',
      re='',
      ex='',
      e = '', 
      un = '';
      //function to post userid and password and accepts full details
postValues() async {
    var bd = json.encode({"userid": uname}); 
    var response = await http.post(
        u+"/coordinator_profile.php",
        body: bd);
    print(response.statusCode);
    r = jsonDecode(response.body);
    print(r);
    //stores the details to string variables
    setState(() {
      n = r['name'];
      d = r['district'];
      l = r['localty'];
      c = r['phone'];
      e = r['email'];
      re=r['verified_requests'];
      ex=r['experience'];
      pr=r['profession'];
      un = r['userid'];
    });
  }
  @override
  Widget build(BuildContext context) {
    f = ModalRoute.of(context).settings.arguments;
    uname=f['username'];
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed:(){},child: Icon(Icons.edit),backgroundColor:Colors.deepOrange ,),
      appBar: AppBar(
        title: Text('Profile'),
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
                    //backgroundImage: new AssetImage("images/profile.jpg"),
                    minRadius: 50,
                  ),
                ),
              ],
            ),
            //Name and profession details
            SizedBox(height: 10,),
            Text(n.toUpperCase(), style: TextStyle(fontSize: 22.0, color: Colors.white,fontWeight: FontWeight.bold),),
            Text(pr, style: TextStyle(fontSize: 14.0, color: Colors.white),)
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
                      title: Text("$ex years",textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0
                      ),),
                      subtitle: Text("of trusted service", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,
                      fontStyle: FontStyle.italic),),
                    ),
                  ),
                ),
                //Details of donors' verified
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: ListTile(
                      title: Text(re,textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24.0
                      ),),
                      subtitle: Text("verified donor requests", textAlign: TextAlign.center, style: TextStyle(color: Colors.white,
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
            subtitle: Text(un, style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("Phone", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text(c, style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("Email", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text(e, style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("Taluk", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text(l, style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
          ListTile(
            title: Text("District", style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
            subtitle: Text(d, style: TextStyle(fontSize: 18.0),),
          ),
          Divider(),
        ],
      )
    );
  }
}
