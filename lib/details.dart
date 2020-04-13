import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final String name;
  final String age;
  final String number;
  final String hospital;
  final String units;
  final String location;
  final String group;

  Details({
    @required this.name,
    @required this.hospital,
    @required this.location,
    @required this.units,
    @required this.group,
    @required this.age,
    @required this.number,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Widget details = new ListView(

      children: <Widget>[
        ListTile(
          title:Text("Patient's Name:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_name_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Bloodgroup",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_Blood_group_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Age",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_age_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Date:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_date_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Units:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_units_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Phone number:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_phone_number_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Alternate number:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_alternate_number_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Hospital:",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_Hospital_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Location(Taluk):",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_location_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("District",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_District_",style: TextStyle(fontSize: 18.0),),
        ),
        ListTile(
          title:Text("Patient address",style: TextStyle(color: Colors.deepOrange, fontSize: 12.0),),
          subtitle:Text("_Patient_address_",style: TextStyle(fontSize: 18.0),),
        ),
        RaisedButton.icon(
             onPressed: (){},
          icon: Icon(Icons.call,color: Colors.white,),
             label: Text("Contact",style: TextStyle(color: Colors.white),),
             color: Colors.deepOrange.shade300,
        ),
      ],
    );
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body:
        details
    );
  }
}
