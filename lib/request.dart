
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'bloodrequest.dart';




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Request',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Request'),
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
  List<String> _blood_groups = <String>['', 'A+ve', 'B+ve', 'AB+ve', 'O+ve', 'A-ve', 'B-ve', 'AB-ve', 'O-ve'];
  String _blood_group = '';
  List<String> _districts = <String>['', 'Kasargod', 'Kannur', 'Kozhikode', 'Wayanad', 'Malappuram', 'Palakkad', 'Thrissur', 'Ernakulam', 'Alappuzha', 'Idukki','Kottayam', 'Pathanamthitta', 'Kollam', 'Thiruvananthapuram'];
  String _district = '';

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
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter full name of patient',
                      labelText: 'Name',
                    ),
                  ),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Blood Group',
                        ),
                        isEmpty: _blood_group == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _blood_group,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                newRequest.bloodgroup = newValue;
                                _blood_group = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _blood_groups.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter age of the patient',
                      labelText: 'Age',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'When you need blood?',
                      labelText: "Date",
                    ),
                    keyboardType: TextInputType.datetime,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'No of units needed',
                      labelText: 'Bloodunits',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter another phone number',
                      labelText: 'Alternate contact',
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),

                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Select District ',
                        ),
                        isEmpty: _district == '',
                        child: new DropdownButtonHideUnderline(
                          child: new DropdownButton(
                            value: _district,
                            isDense: true,
                            onChanged: (String newValue) {
                              setState(() {
                                newRequest.district = newValue;
                                _district = newValue;
                                state.didChange(newValue);
                              });
                            },
                            items: _districts.map((String value) {
                              return new DropdownMenuItem(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name of Taluk',
                      labelText: 'Taluk',
                    ),
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name of Hospital',
                      labelText: 'Hospital',
                    ),
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                        onPressed: null,
                      )),
                ],
              ))),

    );
  }
}

void _submitForm() {
  var _formKey;
  final FormState form = _formKey.currentState;

  if (!form.validate()) {
    showMessage('Form is not valid!  Please review and correct.');
  } else {
    form.save(); //This invokes each onSaved event

    print('Your request has been recorded.. ');

  }
}

void showMessage(String message, [MaterialColor color = Colors.red]) {
  _scaffoldKey.currentState
      .showSnackBar(new SnackBar(backgroundColor: color, content: new Text(message)));
}

