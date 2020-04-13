
import 'package:flutter/material.dart';

import 'utils.dart' as ut;

/*
UI created by Alan (31/03/2020)
 */

class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  bool _isHidden = true;

  void _toggleVisibility(){
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
        theme: ut.maintheme(),
        home:Scaffold(
      body: SingleChildScrollView(

        child: Container(
          padding: EdgeInsets.only(top: 100.0, right: 20.0, left: 20.0, bottom: 20.0),
          decoration: ut.bg(),
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ut.logo(),
            SizedBox(height: 20.0,),
            Text(
              "User Login x",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800]
              ),
            ),
            SizedBox(height: 40.0,),
            buildTextField("Email"),
            SizedBox(height: 20.0,),
            buildTextField("Password"),
            SizedBox(height: 20.0,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Forgotten Password?",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            buildButtonContainer(),
            SizedBox(height: 10.0,),
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account?"),
                    SizedBox(width: 10.0,),
                    Text("SIGN UP", style: TextStyle(color: Theme.of(context).primaryColor,))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        )
    );
  }

  Widget buildTextField(String hintText){
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        prefixIcon: hintText == "Email" ? Icon(Icons.email,
        color: Colors.red[300],) :
        Icon(Icons.lock,color:Colors.red[300]),
        suffixIcon: hintText == "Password" ? IconButton(
          onPressed: _toggleVisibility,
          icon: _isHidden ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
        ) : null,
      ),
      obscureText: hintText == "Password" ? _isHidden : false,
    );
  }

  Widget buildButtonContainer(){
    return Container(
      height: 56.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        gradient: LinearGradient(
          colors: [
            Color(0xFFFB415B),
            Color(0xFFEE5623)
          ],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft
        ),
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
    );

  }
}