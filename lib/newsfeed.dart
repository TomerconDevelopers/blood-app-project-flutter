import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './details.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'globals.dart' as g;

List lis = [];
int index = 0;
Future<List> getData1() async {
  final res = await http.get(
     g.baseUrl+"/newsfeed.php");
  print(res.statusCode);
  return jsonDecode(res.body);
}

//Emergency newsfeed
class EmergencyGroupBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 250.0,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
                padding: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: Colors.redAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.invert_colors,
                            color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text(
                          "Emergency Requirements",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Icon(Icons.filter_list, color: Colors.white, size: 20)
                  ],
                )),
          ),
          FutureBuilder(
              future: getData1(),
              builder: (context, ss) {
                 lis = ss.data;
                if (ss.hasError) {
                  return CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: SizedBox(
                      height: 200,
                      child: ListView.builder(
                          itemCount: lis?.length ?? 0,
                          itemBuilder: (context, index) {
                            Widget w = lis[index]['status'] == 'Emergency'
                                ? EmergencyCard(
                                  i1:index,
                                    group1: lis[index]['bloodgroup'],
                                    name1: lis[index]['name'],
                                    location1: lis[index]['taluk'],
                                    units1: lis[index]['bloodqty'],
                                    hospital1: lis[index]['hospital'])
                                : SizedBox(width: 1);
                            return w;
                          }),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

//Other requirements newsfeed
class GroupBox extends StatelessWidget {
  final String group;
  GroupBox({@required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 250.0,
        child: FutureBuilder(
            future: getData1(),
            builder: (context, ss) {
               lis = ss.data;
              if (ss.hasError) {
                return CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: lis?.length ?? 0,
                    itemBuilder: (context, index) {
                      Widget w = lis[index]['bloodgroup'] == this.group
                          ? RequestCard(
                            i:index,
                              name: lis[index]['name'],
                              location: lis[index]['taluk'],
                              units: lis[index]['bloodqty'],
                              hospital: lis[index]['hospital'])
                          : SizedBox(width: 1);
                      return w;
                    });
              }
            }),
      ),
    );
  }
}

//Emergency requirement card
class EmergencyCard extends StatelessWidget {
  final String name1;
  final String hospital1;
  final String units1;
  final String location1;
  final String group1;
  final int i1;

  EmergencyCard(
      {@required this.name1,
      @required this.hospital1,
      @required this.location1,
      @required this.units1,
      @required this.group1,
      @required this.i1
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(name: lis[i1]['name'],
                                        age: lis[i1]['age'],
                                        date: lis[i1]['date'],
                                        district: lis[i1]['district'],
                                        location: lis[i1]['taluk'],
                                        hospital: lis[i1]['hospital'],
                                        group: lis[i1]['bloodgroup'],
                                        number: lis[i1]
                                            ['bystander_contacts'],
                                        altNumber: lis[i1]
                                            ['bystander_alt_contacts'],
                                        units: lis[i1]['bloodqty'],)),
        );
      },
      child: new Container(
        padding: EdgeInsets.all(5.0),
        height: 120,
        width: 180.0,
        child: Card(
          elevation: 3.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 80,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrange.shade300,
                ),
                child: Center(
                  child: Text(
                    group1,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.face,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(name1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.local_hospital,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(hospital1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(location1,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.invert_colors,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(units1 + " units",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Other requirements card
class RequestCard extends StatelessWidget {
  final String name;
  final String hospital;
  final String units;
  final String location;
  final int i;

  RequestCard(
      {@required this.name,
      @required this.hospital,
      @required this.location,
      @required this.units,
      @required this.i});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details(name: lis[i]['name'],
                                        age: lis[i]['age'],
                                        date: lis[i]['date'],
                                        district: lis[i]['district'],
                                        location: lis[i]['taluk'],
                                        hospital: lis[i]['hospital'],
                                        group: lis[i]['bloodgroup'],
                                        number: lis[i]
                                            ['bystander_contacts'],
                                        altNumber: lis[i]
                                            ['bystander_alt_contacts'],
                                        units: lis[i]['bloodqty'],)),
        );
      },
      child: new Container(
        padding: EdgeInsets.all(5.0),
        height: 120,
        width: 180.0,
        child: Card(
          elevation: 3.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.face,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.local_hospital,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(hospital,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(location,
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.invert_colors,
                        size: 25,
                        color: Colors.deepOrange.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.0),
                      ),
                      Text(units + " units",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 20)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsFeed extends StatefulWidget {
  NewsFeed({Key key, this.emergency,this.group}) : super(key: key);

  final bool emergency;String group;

  @override
  _NewsFeedState createState() => _NewsFeedState(emergency,group);
}

class _NewsFeedState extends State<NewsFeed> {
  bool emergency;//TO FILTER EMERGENCY ONLY
  String group;// TO FILTER BLOOD GROUP
  _NewsFeedState(bool a,String b){
    emergency = a;group = b;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Row(children: <Widget>[
              Text("Newsfeed"),
              SizedBox(width: 10,),
              ut.roundedtext("$group", Colors.white, Colors.red),
              SizedBox(width: 10,),
                if(emergency)ut.roundedtext("emergency", Colors.white,
                    Colors.red)
            ],),

            actions: <Widget>[
              // action button
              IconButton(
                  icon: Icon(Icons.update),
                  color: Colors.white,
                  onPressed: () {
                    return showAlertDialog(context);
                  }),
            ],
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              EmergencyGroupBox(),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'A+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'A+',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'A-',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'A-',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'B+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'B+',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'B-',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'B-',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'AB+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'AB+',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'AB-',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'AB-',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'O+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'O+',
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
                        color: Colors.redAccent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(Icons.invert_colors,
                                    color: Colors.white, size: 20),
                                SizedBox(width: 10),
                                Text(
                                  'O-',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Icon(Icons.filter_list,
                                color: Colors.white, size: 20)
                          ],
                        )),
                  ),
                  GroupBox(
                    group: 'O-',
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.all(10))
            ],
          )),
    );
  }
}

//Dialog box for filtering
filterAlertDialog(BuildContext context) {
  Widget okButton1 = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );

  AlertDialog filter = AlertDialog(
    title: Text("Filter by"),
    content: Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text("Blood group"),
          value: false,
          onChanged: (bool value) {},
          secondary: Icon(Icons.filter_1),
        ),
        CheckboxListTile(
          title: Text("Location"),
          value: false,
          onChanged: (bool value) {},
          secondary: Icon(Icons.filter_2),
        ),
        CheckboxListTile(
          title: Text("Hospital"),
          value: false,
          onChanged: (bool value) {},
          secondary: Icon(Icons.filter_3),
        ),
        CheckboxListTile(
          title: Text("Time"),
          value: false,
          onChanged: (bool value) {},
          secondary: Icon(Icons.filter_4),
        ),
      ],
    ),
    actions: [
      okButton1,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return filter;
    },
  );
}

//Dialog box for availability status
showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Availability status"),
    content: CircularPercentIndicator(
      radius: 120.0,
      lineWidth: 13.0,
      animation: true,
      percent: 0.7,
      center: new Text(
        "70.0%",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      footer: new Text(
        "Days left to be Available",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.red,
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
