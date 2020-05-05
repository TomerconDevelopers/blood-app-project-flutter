import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/calendar.dart';
import 'package:koukicons/callback.dart';
import 'package:koukicons/phone.dart';
import 'package:koukicons/phoneDown.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './details.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'globals.dart' as g;
import 'package:url_launcher/url_launcher.dart';
import 'package:koukicons/alarmClock.dart';

List lis = [];
int index = 0;
String sbg;
var dis, dis1, dis2;
Future<List> getData1() async {
  final SharedPreferences sp = await SharedPreferences.getInstance();
  dis = g.g_bg.isNotEmpty ? sp.getString('district') : null;
  dis1 = g.g_l.isNotEmpty ? sp.getString('district0') : null;
  dis2 = g.g_l.isNotEmpty ? sp.getString('district1') : null;
  final res = await http.get(g.baseUrl + "/newsfeed.php");
  print(res.statusCode);
  return jsonDecode(res.body);
}

//Emergency newsfeed
class EmergencyGroupBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: getData1(),
            builder: (context, ss) {
              lis = ss.data;
              if (!ss.hasData) {
                return SpinKitHourGlass(
                  color: Colors.red,
                  size: 80,
                );
              } else {
                return ListView.builder(
                   itemCount: lis?.length ?? 0,
                    itemBuilder: (context, index) {
                      Widget w = SizedBox(width: 1);

                      if (lis[index]['status'] == 'Emergency') {
                        if (g.g_bg.isNotEmpty) {
                          if (lis[index]['district'] == dis) {
                            w = RequestCard(
                              i: index,
                            );
                          }
                        } else if (g.g_l.isNotEmpty &&
                            dis1 != null &&
                            dis2 != null) {
                          if (lis[index]['district'] == dis1 ||
                              lis[index]['district'] == dis2) {
                            w = RequestCard(
                              i: index,
                            );
                          }
                        } else {
                          w = RequestCard(
                            i: index,
                          );
                        }
                      }

                      return w;
                    });
              }
            }),
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
      padding: const EdgeInsets.all(5.0),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0.0),
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: getData1(),
            builder: (context, ss) {
              lis = ss.data;
              if (!ss.hasData) {
                return SpinKitHourGlass(
                  color: Colors.red,
                  size: 80,
                );
              } else {
                return ListView.builder(
                    itemCount: lis?.length ?? 0,
                    itemBuilder: (context, index) {
                      Widget w = SizedBox(width: 1);
                      if (lis[index]['bloodgroup'] == this.group) {
                        if (g.g_bg.isNotEmpty && dis != null) {
                          if (lis[index]['district'] == dis) {
                            w = RequestCard(
                              i: index,
                            );
                          }
                        } else if (g.g_l.isNotEmpty &&
                            dis1 != null &&
                            dis2 != null) {
                          if (lis[index]['district'] == dis1 ||
                              lis[index]['district'] == dis2) {
                            w = RequestCard(
                              i: index,
                            );
                          }
                        } else {
                          w = RequestCard(
                            i: index,
                          );
                        }
                      }

                      return w;
                    });
              }
            }),
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final int i;

  RequestCard({
    @required this.i,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(5.0),
     // height: 420,
      width: MediaQuery.of(context).size.width,
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: KoukiconsBusinessman(),
                  radius: 30,
                ),
               SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(lis[i]['name'],
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)),
                            Text("Posted on :"+lis[i]['requested_time'].substring(0,10)+","+lis[i]['requested_time'].substring(11,16),
                            style:TextStyle(color:Colors.orange))
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Text(
                  'Approved by ' +
                      lis[i]['coor_id'],
                  style: TextStyle(color: Colors.blue[900], fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    KoukiconsCalendar(),
                    Text("Date : "+lis[i]['date'].substring(0, 10),style: TextStyle(fontWeight:FontWeight.bold),)
                  ],
                ),
                Column(
                  children: <Widget>[
                    KoukiconsAlarmClock(),
                    Text("Time : "+lis[i]['date'].substring(11, 16),style: TextStyle(fontWeight:FontWeight.bold),)
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Text(
              'Hospital : ' + lis[i]['hospital'] + ", " + lis[i]['taluk'],
              style: TextStyle(color: Colors.grey, fontSize: 19),
            ),
            SizedBox(height: 10),
           Row(children: <Widget>[
               ut.roundedtext('Required units :' + lis[i]['bloodqty'],
                Colors.red, Colors.white),
                SizedBox(width: 2,),
                ut.roundedtext(lis[i]['bloodgroup'], Colors.red, Colors.white)
           ],) ,

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.location_on,color: Colors.blue,),
                Text(
              lis[i]['taluk'] + "," + lis[i]['district'],
              style: TextStyle(color: Colors.blue[900], fontSize: 16),
            ),
            Expanded(child: SizedBox()),
                CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey[100],
                    child: IconButton(
                        icon: KoukiconsCallback(
                          color: Colors.green,
                        ),
                        onPressed: () {
                          launch("tel://" + lis[i]['bystander_contacts']);
                        })),
              ],
            )
          ],
        ),
      )),
    );
  }
}

class NewsFeed extends StatefulWidget {
  NewsFeed({Key key, this.emergency, this.group}) : super(key: key);

  final bool emergency;
  String group;

  @override
  _NewsFeedState createState() => _NewsFeedState(emergency, group);
}

class _NewsFeedState extends State<NewsFeed> {
  bool emergency; //TO FILTER EMERGENCY ONLY
  String group;
  // TO FILTER BLOOD GROUP
  _NewsFeedState(bool a, String b) {
    emergency = a;
    group = b;
    sbg = group;
    if (emergency == true) sbg = null;
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text("Newsfeed"),
               Expanded(child: SizedBox()),
                emergency == false
                    ? DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isDense: true,
                          //hint: ut.roundedtext(
                         //     'Choose', Colors.white, Colors.red),
                          isExpanded: false,
                          items: g.bloodgroup.map((lisVal) {
                            return DropdownMenuItem<String>(
                              value: lisVal,
                              child:
                                  ut.roundedtext(
                                      lisVal, Colors.white, Colors.red),
                                 
                               
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              sbg = val;
                            });
                          },
                          value: sbg,
                        ),
                      )
                    : SizedBox(width: 1),

                //ut.roundedtext("$group", Colors.white, Colors.red),
                SizedBox(
                  width: 2,
                ),
                 Center(
                  child: GestureDetector(
                    child:
                        ut.roundedtext("Emergency", Colors.white, Colors.red),
                    onTap: () {
                      setState(() {
                        emergency = true;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: Colors.orange[50],
            child: 
                emergency == true
                    ? EmergencyGroupBox()
                    : GroupBox(
                        group: sbg,
                      ),
                
          )),
    );
  }
}
