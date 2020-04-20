
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'globals.dart' as g;

class EditCoordinatorProfile extends StatefulWidget {
  EditCoordinatorProfile({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditCoordinatorProfileState createState() => _EditCoordinatorProfileState();
}

class _EditCoordinatorProfileState extends State<EditCoordinatorProfile> {
  Map f={};
  String u=g.baseUrl;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String sbg,db,tl;
  TextEditingController un = new TextEditingController();
  TextEditingController c = new TextEditingController();
  TextEditingController e = new TextEditingController();
  TextEditingController l = new TextEditingController();
  TextEditingController d = new TextEditingController();
  List s=[];

  @override
  void initState() {
    postValues();
    super.initState();
  }

  String uname = '';
  var r;
  String n = '',
      pr = '',
    // d = '',
    //  l = '',
    //  c = '',
     re = '',
      ex = '',
  //    e = '',
  //    un = '';

  //function to post userid and password and accepts full details
  postValues() async {
    var bd = json.encode({"userid": uname});
    var response = await http.post(
        u + "/coordinator_profile.php",
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
      re = r['verified_requests'];
      ex = r['experience'];
      pr = r['profession'];
      un = r['userid'];
    });
  }

  @override
  Widget build(BuildContext context) {
    f = ModalRoute
        .of(context)
        .settings
        .arguments;
    uname = f['username'];
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {},
        child: Icon(Icons.edit),
          backgroundColor: Colors.deepOrange,),
          appBar: AppBar(
          title: Text('Edit Coordinator Profile'),
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
                    Text(n.toUpperCase(), style: TextStyle(fontSize: 22.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),),
                    Text(
                        pr, style: TextStyle(fontSize: 14.0, color: Colors.white),)
                        ],),
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
                        title: Text("$ex years", textAlign: TextAlign.center,
                          style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0
                          ),),
                        subtitle: Text(
                          "of trusted service", textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                          fontStyle: FontStyle.italic),),
                          ),
                          ),
                          ),
                          //Details of donors' verified
                  Expanded(
                    child: Container(
                      color: Colors.red,
                      child: ListTile(
                        title: Text(
                        re, textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0
                        ),),
                        subtitle: Text("verified donor requests",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white,
                          fontStyle: FontStyle.italic),),
                          ),
                          ),
                          ),
                        SizedBox(
                            height: 20,
                            ),
                            EditForm()
                          ],
                          ),
                          ),
                          ],
    ); }

        EditForm {
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

                                controller: un,
                                style: TextStyle(fontSize: 20),

                                decoration: InputDecoration(
                                    prefixIcon: (Icon(Icons.mood,color:Color(0xFFFB415B))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(color:Color(0xFFFB415B))
                                    ),
                                    labelText: 'Coordinator ID',
                                    labelStyle:
                                    TextStyle(color: Colors.deepOrange, fontSize: 12.0)),
                              ),
                              SizedBox(
                                height: 20,
                              ),


                              TextFormField(
                                validator: (value) {
                                  var potentialNum = int.tryParse(value);
                                  if (potentialNum == null) {
                                    return 'Please enter a valid contact number';
                                  } else {
                                    return null;
                                  }
                                },
                                controller: c,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(fontSize: 20),
                                decoration: InputDecoration(
                                    prefixIcon: (Icon(Icons.phone,color:Color(0xFFFB415B))),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    labelText: 'Phone',
                                    labelStyle:
                                    TextStyle(color: Colors.deepOrange, fontSize: 12.0)),
                              ),
                              SizedBox(
                                height: 20,
                              ),

                              TextFormField(
                                validator: (value) =>
                                value.isEmpty? 'Field required...' : null,

                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                controller: e,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    prefixIcon: (Icon(Icons.email,color:Color(0xFFFB415B))),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                        borderSide: BorderSide(color:Color(0xFFFB415B))
                                    ),
                                    labelText: 'Email',
                                    labelStyle:
                                    TextStyle(color: Colors.deepOrange, fontSize: 12.0)),
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
                                                color: Colors.deepOrange, fontSize: 12.0)),Divider()
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
                                items: s.map((lisVal) {
                                  return DropdownMenuItem<String>(
                                    value: lisVal,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(lisVal,
                                            style: TextStyle(
                                                color: Colors.deepOrange, fontSize: 12.0)),Divider()
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


                              Center(
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ]
                        ),
                      )));
            }

        }
        void _submitForm() {
        final FormState form = _formKey.currentState;

        if (!_formKey.currentState.validate()) {
        showMessage('Form is not valid!  Please review and correct.');
        } else {
        form.save(); //This invokes each onSaved event
        print('Your profile is edited.. ');

        }
        }

        void showMessage(String message, [MaterialColor color = Colors.red]) {
        _scaffoldKey.currentState
            .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message,style: TextStyle(fontSize: 16,),)));
        }


