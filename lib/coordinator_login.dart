import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revive/coord_pass_reset.dart';
import 'package:revive/home.dart';
import 'utils.dart' as ut;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as g;
/*
UI created by Sandra 
 */

class CoordinatorLoginPage extends StatefulWidget {
  @override
  _CoordinatorLoginPageState createState() => _CoordinatorLoginPageState();
}

class _CoordinatorLoginPageState extends State<CoordinatorLoginPage> {
  http.Response res;
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  TextEditingController em = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ut.maintheme(),
        home: Scaffold(
            body: Container(
              decoration: ut.bg(),
              child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.only(
                  top: 100.0, right: 20.0, left: 20.0, bottom: 20.0),
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ut.logo(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Coordinator Login",
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800]),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  buildTextField("Username", em),
                  SizedBox(
                    height: 20.0,
                  ),
                  buildTextField("Password", pass),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          onTap: ()=>Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PasswordReset())),
                                                  child: Text(
                            "Forgotten Password?",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.0),
                  buildButtonContainer(),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
          ),
        ),
            )));
  }

  Widget buildTextField(String hintText, TextEditingController t) {
    return TextFormField(
      controller: t,
      validator: (val) => val.isEmpty ? 'Field required' : null,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: hintText == "Username"
            ? Icon(
                Icons.email,
                color: Colors.red[300],
              )
            : Icon(Icons.lock, color: Colors.red[300]),
        suffixIcon: hintText == "Password"
            ? IconButton(
                onPressed: _toggleVisibility,
                icon: _isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              )
            : null,
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }

  Widget buildButtonContainer() {
    return InkWell(
      onTap: () async {
        var bd = json.encode({"uname": em.text, "pass":pass.text});
        print(ut.encrypt(pass.text));
        res = await http.post(g.baseUrl+"/coordinator_login.php",
            body: bd);
        print(res.statusCode);
        var reg=jsonDecode(res.body);
        print(reg);
        if (reg != "Invalid Username/Password") {
          var r = json.decode(res.body);
          print(r['name']);
          String capname = r['name'];
          final SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setString("name", r['name']);
          sp.setString("username", r['userid']);
          sp.setString("password", r['password']);
          sp.setString("district", r['district']);
          sp.setString("phone", r['phone']);
          sp.setString("email", r['email']);
          sp.setString("verified_requests", r['verified_requests']);
          sp.setString("location", r['localty']);
          sp.setString("experience", r['experience']);
          sp.setString("profession", r['profession']);
          sp.setString("photo_upload", r['photo_upload']);
          setState(() {
            Navigator.pop(context, () {
              setState(() {});
            });
            showDialog(
                context: context,
                child: AlertDialog(
                  content: Text(
                    "Welcome back " + capname.toUpperCase(),
                    style: TextStyle(fontSize: 20, color: Color(0xFFEE5623)),
                  ),
                ));
          });
        } else {
         
          setState(() {
            showDialog(
                context: context,
                child: AlertDialog(
                  content: Text(reg,
                      style: TextStyle(fontSize: 20, color: Color(0xFFEE5623))),
                  actions: <Widget>[
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text("OK",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFFEE5623),
                            )))
                  ],
                ));
          });
        }
      },
      child: Container(
        height: 56.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          gradient: LinearGradient(
              colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft),
        ),
        child: Center(
          child: Text(
            "LOGIN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
