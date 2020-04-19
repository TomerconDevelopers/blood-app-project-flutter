
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'bloodrequest.dart';
import 'globals.dart' as g;
import 'package:http/http.dart' as http;
import 'utils.dart' as ut;



class BloodRequest extends StatefulWidget {
  BloodRequest({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _BloodRequestState createState() => new _BloodRequestState();
}
Request newRequest = new Request();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _BloodRequestState extends State<BloodRequest> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String sbg,d,tl,re="";
TextEditingController fn = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController cn = new TextEditingController();
  TextEditingController acn = new TextEditingController();
  TextEditingController ld = new TextEditingController();
  TextEditingController u = new TextEditingController();
  TextEditingController h = new TextEditingController();
  List l=[];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
          home: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(
            leading: IconButton(onPressed: ()=>Navigator.pop(context),icon: Icon(Icons.arrow_back_ios),),
            title: new Text("Blood request"),
          ),
          body: new SafeArea(
              top: false,
              bottom: false,
              child: SingleChildScrollView(
                            child: new Form(
                    key: _formKey,
                    autovalidate: true,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: new Column(
                        children: <Widget>[
                          SizedBox(height: 30,),
                          new TextFormField(
                                    //first name
                                    validator: (value) =>
                                        value.isEmpty? 'Field required...' : null,
                                    
                                    controller: fn,
                                    style: TextStyle(fontSize: 20),

                                    decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.mood,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(color:Color(0xFFFB415B))
                                      ),
                                        labelText: 'Name',
                                        labelStyle:
                                            TextStyle(color: Colors.black, fontSize: 20)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                           DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.invert_colors,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                      )
                                    ),
                                    isExpanded: true,
                                    validator: (value) =>
                                        value == null ? 'Field required...' : null,
                                    hint: Text('Choose Blood group',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 20)),
                                    items: g.bloodgroup.map((lisVal) {
                                      return DropdownMenuItem<String>(
                                        value: lisVal,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(lisVal,
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 20)),Divider()
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
                          new TextFormField(
                                    
                                    validator: (value) =>
                                        value.isEmpty? 'Field required...' : null,
                                    controller: age,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.cake,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      labelText: 'Age',
                                      labelStyle:
                                          TextStyle(color: Colors.black, fontSize: 20),
                                      hintText: 'Enter age',
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                          new TextFormField(
                                    controller: ld,
                                    validator:(value)=>value.isEmpty? 'Field required...' : null,
                                    keyboardType: TextInputType.datetime,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.calendar_today,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      labelText:'Date',
                                      labelStyle:
                                          TextStyle(color: Colors.black, fontSize: 20),
                                      hintText: 'When you need blodd?(YYYY-MM-DD)',
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                          new TextFormField(
                            validator:(value)=>value.isEmpty? 'Field required...' : null,
                                    controller: u,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.dock,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      labelText:'Units',
                                      labelStyle:
                                          TextStyle(color: Colors.black, fontSize: 20),
                                      hintText: 'Units of blood you need',
                                    ),
                                  ),
                                  SizedBox(height: 20,),
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
                                      prefixIcon: (Icon(Icons.phone,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                        labelText: 'Contact number',
                                        labelStyle:
                                            TextStyle(color: Colors.black, fontSize: 20)),
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
                                      prefixIcon: (Icon(Icons.phone,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                        labelText: 'Alternate Contact number',
                                        labelStyle:
                                            TextStyle(color: Colors.black, fontSize: 20)),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),

                         DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.home,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                      )
                                    ),
                                    isExpanded: true,
                                    validator: (value) =>
                                        value == null ? 'Field required...' : null,
                                    hint: Text('Choose District',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 20)),
                                    items: g.districts.map((lisVal) {
                                      return DropdownMenuItem<String>(
                                        value: lisVal,
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(lisVal,
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 20)),Divider()
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
                                      prefixIcon: (Icon(Icons.home,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                      )
                                    ),
                                    isExpanded: true,
                                    validator: (value) =>
                                        value == null ? 'Field required...' : null,
                                    hint: Text('Choose Taluk',
                                        style:
                                            TextStyle(color: Colors.black, fontSize: 20)),
                                    items: l.map((lisVal) {
                                      return DropdownMenuItem<String>(
                                        value: lisVal,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(lisVal,
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 20)),Divider()
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
                          
                           new TextFormField(
                            validator:(value)=>value.isEmpty? 'Field required...' : null,
                                    controller: h,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      prefixIcon: (Icon(Icons.local_hospital,color:Color(0xFFFB415B))),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      labelText:'Hospital',
                                      labelStyle:
                                          TextStyle(color: Colors.black, fontSize: 20),
                                      hintText: 'Hospital name',
                                    ),
                                  ),
                          new SizedBox(height:20),
                                  //button
                                  InkWell(
                                    
                                    onTap: (){_submitForm();},
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
                  end: Alignment.centerLeft
                ),
            ),
            child: Center(
                child: Text(
                  "SUBMIT",
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
                    )),
              )),

        ),
    )
    ;
  }
  void _submitForm() {
  final FormState form = _formKey.currentState;

  if (!_formKey.currentState.validate()) {
    showMessage('Form is not valid!  Please review and correct.');
  } else {
    form.save(); 

    postData1(context,g.baseUrl);//This invokes each onSaved event
  }
}

void showMessage(String message, [MaterialColor color = Colors.red]) {
  _scaffoldKey.currentState
      .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message,style: TextStyle(fontSize: 16,),)));
}


postData1(BuildContext context,String s)async{
  var bd=json.encode({
    "name":fn.text,
    "age":age.text,
    "bloodgroup":sbg,
    "date":ld.text,
    "district":d,
    "taluk":tl,
    "qty":u.text,
    "contacts":cn.text,
    "alt_contacts":acn.text,
    "hospital":h.text,
  });
    http.Response res=await http.post(s+"/request.php",body:bd);
    print(res.statusCode);    
    print(res.body);
    re=jsonDecode(res.body);
    print(re);
    if(re!="Contact number Already Exists..!" && re!="Try Again"){
      Navigator.pop(context);
    } 
    showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(         
              content: Text(
                jsonDecode(res.body),
                style: TextStyle(fontSize: 20, color: Colors.purpleAccent),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              contentPadding: EdgeInsets.all(20),
            );
          });
}
}

