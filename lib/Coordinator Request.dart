import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'utils.dart' as ut;
import 'globals.dart' as g;

class BloodRequestDetails extends StatefulWidget {
  final String name;
  final String age;
  final String date;
  final String district;
  final String number;
  final String altNumber;
  final String hospital;
  final String units;
  final String taluk;
  final String group;

  BloodRequestDetails({
    @required this.name,
    @required this.age,
    @required this.date,
    @required this.district,
    @required this.taluk,
    @required this.hospital,
    @required this.group,
    @required this.number,
    @required this.altNumber,
    @required this.units,
  });

  @override
  _BloodRequestDetailsState createState() => _BloodRequestDetailsState(
      this.name,
      this.age,
      this.date,
      this.group,
      this.units,
      this.number,
      this.altNumber,
      this.district,
      this.taluk,
      this.hospital);
}

class _BloodRequestDetailsState extends State<BloodRequestDetails> {
  final GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  List status = ["Emergency", "Not Emergency"];
  List verify = ["Verified", "Rejected"];
  var stat, ve;
  TextEditingController id = TextEditingController();
  String name;
  String age;
  String date;
  String district;
  String number;
  String altNumber;
  String hospital;
  String units;
  String taluk;
  String group;
  _BloodRequestDetailsState(String n, String a, String da, String grp,
      String un, String nu, String altNu, String di, String tlk, String hos) {
    this.name = n;
    this.age = a;
    this.date = da;
    this.district = di;
    this.taluk = tlk;
    this.number = nu;
    this.altNumber = altNu;
    this.hospital = hos;
    this.units = un;
    this.group = grp;
  }
  String reg = "";
  @override
  Widget build(BuildContext context) {
    Widget details = new ListView(
      children: <Widget>[
        ListTile(
          title: Text(
            "Patient's Name:",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            name.toUpperCase(),
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Bloodgroup",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            group,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Age",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            age,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Date:",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            date,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Units:",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            units,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Phone number:",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            number,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Alternate number:",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            altNumber,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "District",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            district,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Location(Taluk):",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            taluk,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        ListTile(
          title: Text(
            "Hospital:",
            style: TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
          ),
          subtitle: Text(
            hospital,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        SingleChildScrollView(
          child: Form(
              autovalidate: true,
              key: _formKey1,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "Status:",
                      style:
                          TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
                    ),
                    subtitle: DropdownButtonFormField<String>(
                      isExpanded: true,
                      validator: (value) =>
                          value == null ? 'Field required...' : null,
                      hint: Text('Status',
                          style: TextStyle(color: Colors.grey, fontSize: 20)),
                      items: status.map((lisVal) {
                        return DropdownMenuItem<String>(
                          value: lisVal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(lisVal, style: TextStyle(fontSize: 20)),
                              Divider()
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          this.stat = val;
                        });
                      },
                      value: this.stat,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Verification status:",
                      style:
                          TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
                    ),
                    subtitle: DropdownButtonFormField<String>(
                      isExpanded: true,
                      validator: (value) =>
                          value == null ? 'Field required...' : null,
                      hint: Text('Verification status',
                          style: TextStyle(color: Colors.grey, fontSize: 20)),
                      items: verify.map((lisVal) {
                        return DropdownMenuItem<String>(
                          value: lisVal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(lisVal, style: TextStyle(fontSize: 20)),
                              Divider()
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (String val) {
                        setState(() {
                          this.ve = val;
                        });
                      },
                      value: this.ve,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Coordinator id:",
                      style:
                          TextStyle(color: Color(0xFFEE5623), fontSize: 15.0),
                    ),
                    subtitle: TextFormField(
                      validator: (value) =>
                          value.isEmpty ? 'Field required...' : null,
                      controller: id,
                      style: TextStyle(fontSize: 20),
                      decoration: InputDecoration(
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 20),
                        hintText: 'Enter Coordinator username',
                      ),
                    ),
                  ),
                ],
              )),
        ),
        InkWell(
          onTap: () {
            if (_formKey1.currentState.validate()) {
              
                postData3(context,g.baseUrl);
                
             
            }
            else{
              print('invalid');
            }
          },
          child: Container(
            margin: EdgeInsets.all(30),
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
                "POST",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        )
      ],
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(name.toUpperCase()),
        ),
        body: details);
  }

  postData3(BuildContext context,String s) async {
    
    var bd = json.encode({
      "name": this.name,
      "age": this.age,
      "bloodgroup": this.group,
      "district": this.district,
      "localty": this.taluk,
      "contacts": this.number,
      "alt_contacts": this.altNumber,
      "date": this.date,
      "status": stat,
      "units": this.units,
      "hosp": this.hospital,
      "verified": ve,
      "id": id.text
    });
    var res = await http.post(
        s+"/coordinator_request.php",
        body: bd);
    print(res.statusCode);
    reg = jsonDecode(res.body);
    print(reg);
     if(reg!="Try Again"){
       setState(() {
         Navigator.pop(context,(){
           setState(() {
             
           });
         });
         ut.showtoast(reg,Colors.green);
       });
     }
    reg = '';
  }
}
