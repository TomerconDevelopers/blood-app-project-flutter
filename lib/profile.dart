import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String uname = '', pass = '';
  var r;
  String n = '',
      f = '',
      g = '',
      a = '',
      w = '',
      b = '',
      d = '',
      l = '',
      c = '',
      ac = '',
      e = '',
      ld = '',
      s = '',
      at = '',
      un = '';
      //function which takes the username and password of the current user logged in and posts it to fetch the details
  postValues() async {
    SharedPreferences sp=await SharedPreferences.getInstance();
    uname=sp.getString('username');
    pass=sp.getString('password');
    var bd = json.encode({"uname": uname, "pass": pass});
    
    var response = await http.post(
        "http://192.168.111.2/blood-app-project-backend-master/profile.php",
        body: bd);
    print(response.statusCode);
    r = jsonDecode(response.body);
    print(r);
    //stores the details to string variables
    setState(() {
      f = r['name'][0];
      n = r['name'];
      a = r['age'];
      g = r['gender'];
      w = r['weight'];
      b = r['bloodgroup'];
      d = r['district'];
      l = r['localty'];
      c = r['contacts'];
      ac = r['alt_contact_no'];
      e = r['email'];
      ld = r['last_don'];
      s = r['status'];
      at = r['for_time'];
      un = r['username'];
    });
  }

  @override
  void initState() {
    super.initState();
    //when app starts this is called
    postValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[Text('Profile'), Icon(Icons.edit)],
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: <Widget>[
          Container(
              child:Image.asset('assets/images/bg.png'),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),
          Positioned(
              top:100,
              bottom:20,
              left: 20,
              right: 20,
              child: SizedBox(
                child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.2), BlendMode.dstATop),
                    child: Image.asset('assets/images/logo.png')),
                height: 50,
                width: 50,
              )),
          Scrollbar(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.all(70),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.pink, width: 10)),
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 30, top: 0, right: 30, bottom: 40),
                    padding: EdgeInsets.all(20),
                    height: 700,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.pink, width: 5)),
                    child: ListView(
                      children: <Widget>[
                        CircleAvatar(
                            child: Center(
                                child: Text(f,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 70))),
                            radius: 40,
                            backgroundColor: Colors.pink),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Text(
                          n.toUpperCase(),
                          style: Theme.of(context).textTheme.title,
                        )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Age',
                                style: Theme.of(context).textTheme.title),
                            //Text(':',style: Theme.of(context).textTheme.title),
                            Text(a, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Gender',
                                style: Theme.of(context).textTheme.title),
                            Text(g, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Weight',
                                style: Theme.of(context).textTheme.title),
                            Text(w, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Blood Group',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(b, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('District',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(d, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Localty',
                                style: Theme.of(context).textTheme.title),
                           
                            Text(l, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Contact number',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(c, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Alternate Contact number',
                                style: Theme.of(context).textTheme.title),
                           
                            Text(ac, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Email',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(e, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Last Donation Date',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(ld, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Status',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(s, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Status active period',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(at, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Username',
                                style: Theme.of(context).textTheme.title),
                            
                            Text(un, style: Theme.of(context).textTheme.title)
                          ],
                        ),
                        Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Container(
                              width: 100.0,
                              height: 40,
                              child: RaisedButton(
                                onPressed: () {},
                                child: Text('Edit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.pink)),
                                color: Colors.pink,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
