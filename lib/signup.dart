import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:revive/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'globals.dart' as g;
import 'utils.dart' as ut;

/* creted by Sandra*/

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _SignUpState extends State<SignUp> {
  //textediting controllers for all fields
  TextEditingController fn = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController cn = new TextEditingController();
  TextEditingController acn = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController ld = new TextEditingController();
  TextEditingController forTime = new TextEditingController();
  TextEditingController ft = new TextEditingController();
  TextEditingController un = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController repass = new TextEditingController();

//required variables
  var t, r;
  Widget w = SizedBox(height: 10);
  String reg = "", sbg, st, gen, d, tl, p, m;
  final GlobalKey<FormState> _key1 = new GlobalKey<FormState>();

  List gender = ['Male', 'Female', 'Others'];
  bool checked = false;
  List status = ['Available anytime', 'Available for', 'Unavailable for'];

  List med = [
    'None',
    'HIV',
    'Heart disease',
    'Hypertension',
    'Cancer',
    'Received Hepatitis B vaccine',
    'Major dental procedures/general surgeries in the past 1 month',
    'Fits',
    'Asthma',
    'Epilepsy',
    'Kidney ailments',
    'Diabetes',
    'Ear/body piercing/tatoo in past 6 months',
    'Undergone Immunization in the past 1 month',
    'Treated for rabies',
    'Pregnant/breast feeding',
    'Women undergone miscarriage in the past 6 months',
    'Tuberculosis',
    'Allergy to a substance used in blood donation/Severe allergy/unwell at the time of donation due to allergy'
  ];
  //list of districts

  List l = [];
  //mapping districts to their taluks

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: true,
        body: Container(
          //upper beizer curved container
          decoration: ut.bg(),
          child: Scrollbar(
            child: ListView(
              children: <Widget>[
                ClipPath(
                  clipper: ClippingClass(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFFFB415B), Color(0xFFEE5623)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20),
                          child: Text(
                            'Welcome',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'To our family',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        autovalidate: true,
                        key: _key1,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              //first name
                              validator: (value) =>
                                  value.isEmpty ? 'Field required...' : null,

                              controller: fn,
                              style: TextStyle(fontSize: 20),

                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.mood,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                      borderSide:
                                          BorderSide(color: Color(0xFFFB415B))),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            //gender dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.wc,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose gender',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: gender.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider(),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  this.gen = val;
                                });
                              },
                              value: this.gen,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //age field
                            TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? 'Field required...' : null,
                              controller: age,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                prefixIcon: (Icon(Icons.cake,
                                    color: Color(0xFFFB415B))),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Age',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                hintText: 'Between 18 and 65',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //weight field
                            TextFormField(
                              validator: (value) =>
                                  value.isEmpty ? 'Field required...' : null,
                              controller: weight,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.timelapse,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Weight(in Kg)',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                  hintText: 'Should be 50 or above'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //blood group dropdown
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.invert_colors,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose Blood group',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: g.bloodgroup.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider()
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  this.sbg = val;
                                });
                              },
                              value: this.sbg,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //district selector
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.home,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose District',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: g.districts.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider()
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  this.d = val;
                                  l = g.tlk[d];
                                });
                                tl = null;
                              },
                              value: this.d,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //taluk selector
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.home,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose Taluk',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: l.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider()
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  this.tl = val;
                                  print(tl);
                                });
                              },
                              value: this.tl,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //contact number
                            TextFormField(
                              validator: (value) => value.isEmpty
                                  ? 'Field required...'
                                  : value.length != 10
                                      ? 'Enter a valid number'
                                      : null,
                              controller: cn,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.phone,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Contact number',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //alternate contact number
                            TextFormField(
                              validator: (value) {
                                if (value.isNotEmpty && value.length != 10) {
                                  return 'Please enter a valid contact number';
                                } else {
                                  return null;
                                }
                              },
                              controller: acn,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.phone,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Alternate Contact number',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //email
                            TextFormField(
                              controller: mail,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.mail,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //last donated
                            TextFormField(
                              controller: ld,
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                prefixIcon: (Icon(Icons.calendar_today,
                                    color: Color(0xFFFB415B))),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Last Donated on',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                hintText: 'YYYY-MM-DD',
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //status-available or unavailable
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.event_available,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text('Choose Status',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: status.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider()
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  this.st = val;
                                  if (st != status[0]) {
                                    w = callFor();
                                  } else {
                                    w = SizedBox(height: 10);
                                  }
                                });
                              },
                              value: this.st,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            w, //if available for/unavailable for till when its valid

                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.local_hospital,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0))),
                              isExpanded: true,
                              validator: (value) =>
                                  value == null ? 'Field required...' : null,
                              hint: Text(
                                  'Do you have any of the medical conditions given?',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              items: med.map((lisVal) {
                                return DropdownMenuItem<String>(
                                  value: lisVal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(lisVal,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      Divider(),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String val) {
                                setState(() {
                                  this.m = val;
                                });
                              },
                              value: this.m,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //username
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a username';
                                } else {
                                  return null;
                                }
                              },
                              controller: un,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.person,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            //password
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter the password';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              controller: pass,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.lock,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value != pass.text) {
                                  return "Passwords don't match";
                                } else {
                                  return null;
                                }
                              },
                              obscureText: true,
                              controller: repass,
                              keyboardType: TextInputType.visiblePassword,
                              style: TextStyle(fontSize: 20),
                              decoration: InputDecoration(
                                  prefixIcon: (Icon(Icons.lock,
                                      color: Color(0xFFFB415B))),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Checkbox(
                                      value: checked,
                                      onChanged: (bool val) {
                                        setState(() {
                                          checked = val;
                                        });
                                      }),
                                ),
                                //agreement
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                      "I hereby declare that information furnished above is true to the best of my knowledge.If any of thr above information is found to be wrong,I will be solely responsible for anything resulting out of it and any loss or damage sustained to the government/any other person/agency.",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            //button
                            InkWell(
                              onTap: () {
                                if (checked == true) {
                                  callIt(context);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.all(30),
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
                                      end: Alignment.centerLeft),
                                ),
                                child: Center(
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final FormState form = _key1.currentState;
    if (!_key1.currentState.validate()) {
      showMessage('Form is not valid!  Please review and correct.');
    } else {
      form.save(); //This invokes each onSaved event
      print('Your request has been recorded.. ');
    }
  }

  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: color,
        content: new Text(
          message,
          style: TextStyle(
            fontSize: 16,
          ),
        )));
  }

  callIt(BuildContext context) {
    setState(() {
      //checking weight and age
      if (!_key1.currentState.validate()) {
        _submitForm();
      } else {
        if (int.parse(weight.text) < 50 ||
            int.parse(age.text) < 18 ||
            int.parse(age.text) > 65 ||
            m != 'None') {
              Navigator.pop(context);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Sorry,You're not eligible to register",
                      style: TextStyle(fontSize: 20, color: Colors.red)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  contentPadding: EdgeInsets.all(20),
                );
              });
        }

        // if every data is available post details
        else {
          postData(g.baseUrl,context);
        }
      }
    });
  }

  //to set username and password
  setPrefs1() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    Future<bool> u = sp.setString("username", un.text);
    Future<bool> v = sp.setString("name", fn.text);
    Future<bool> w = sp.setString("blood_group", sbg);
    sp.setString("gender",gen.toLowerCase());
    sp.setString("district", d);
    sp.setString("age",age.text);
    sp.setString("weight", weight.text);
    sp.setString("taluk", tl);
     sp.setString( "contacts", cn.text);
      sp.setString("alt_contact", acn.text);
       sp.setString("email", mail.text);
       sp.setString("last_don", ld.text);
       sp.setString("status", st);
       sp.setString("for_time",forTime.text);
    //print(u);
    Future<bool> pa = sp.setString("password",ut.encrypt(pass.text));
    // print(pa);
  }

  postData(String s,BuildContext context) async {
    String g = gen.toLowerCase();
    p = ut.encrypt(pass.text);
    var bd = json.encode({
      "name": fn.text,
      "gender": g,
      "age": age.text,
      "weight": weight.text,
      "bloodgroup": sbg,
      "district": d,
      "localty": tl,
      "contacts": cn.text,
      "alt_contact": acn.text,
      "email": mail.text,
      "last_don": ld.text,
      "status": st,
      "for_time": forTime.text,
      "uname": un.text,
      "password": p
    });
    var res = await http.post(
        s+"/signup.php", 
        body: bd);
    print(res.statusCode);
    reg = jsonDecode(res.body);
    print(res.body); 
    if(reg!="Contact number Already Exists..!" && reg!="Username Already Exists..!"){
      Navigator.pop(context);
      setPrefs1();
    } 
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(         
              content: Text(
                jsonDecode(res.body),
                style: TextStyle(fontSize: 20, color:  Color(0xFFEE5623)),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              contentPadding: EdgeInsets.all(20),
            );
          });
     reg='';
  }

  Widget callFor() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter the time upto which status is active";
        } else {
          return null;
        }
      },
      controller: forTime,
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        labelText: 'Status active till',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
        hintText: 'YYYY-MM-DD',
      ),
    );
  }
}

// to clip the path
class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
