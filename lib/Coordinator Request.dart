
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'bloodrequest.dart';
import 'globals.dart' as g;

class BloodRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Request',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'CoordinatorRequest'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}
Request newRequest = new Request();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String sbg,d,tl;
  TextEditingController cid = new TextEditingController();
TextEditingController fn = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController cn = new TextEditingController();
  TextEditingController acn = new TextEditingController();
  TextEditingController ld = new TextEditingController();
  TextEditingController u = new TextEditingController();
  List l=[];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                              hintText: 'Between 18 and 65',
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
                            validator: (value) {
                              var potentialNum = int.tryParse(value);
                              if (potentialNum == null) {
                                return 'Please enter a valid contact number';
                              } else {
                                return null;
                              }
                            },
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
                    decoration: const InputDecoration(
                      hintText: 'Name of Hospital',
                      labelText: 'Hospital',
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
              ))),

    );
  }
  void _submitForm() {
  final FormState form = _formKey.currentState;

  if (!_formKey.currentState.validate()) {
    showMessage('Form is not valid!  Please review and correct.');
  } else {
    form.save(); //This invokes each onSaved event
    print('Your request has been recorded.. ');

  }
}

void showMessage(String message, [MaterialColor color = Colors.red]) {
  _scaffoldKey.currentState
      .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message,style: TextStyle(fontSize: 16,),)));
}


}

