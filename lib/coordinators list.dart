import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:koukicons/businessman.dart';
import 'package:koukicons/callback.dart';
import 'package:revive/coord_details.dart';
import 'package:revive/coordinator_profile.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'globals.dart' as g;
import 'dart:convert';

class CoordinatorsList extends StatefulWidget {
  @override
  _CoordinatorsListState createState() => _CoordinatorsListState();
}

class _CoordinatorsListState extends State<CoordinatorsList> {
  List lis = [];
  Future<List> getData() async {
    final res = await http.get(g.baseUrl + "/coordinator_list.php");
    print(res.statusCode);
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Coordinators'),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
            future: getData(),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              lis = snapshot.data;
              if (!snapshot.hasData) {
                return Center(
                  child: SpinKitHourGlass(
                    color: Colors.red,
                    size: 80,
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: lis?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(5.0),
                        // height: 420,
                        width: MediaQuery.of(context).size.width,
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CoordinatorDetails(
                                    name: lis[index]['name'],
                                    phone: lis[index]['phone'],
                                    mail: lis[index]['email'],
                                    taluk: lis[index]['localty'],
                                    district: lis[index]['district'],
                                    ve_re: lis[index]['verified_requests'],
                                    experience: lis[index]['experience'],
                                    profession: lis[index]['profession'],
                                    id: lis[index]['userid'],
                                    dis0: lis[index]['district0'],
                                    dis1: lis[index]['district1'])),
                          ).then((var value) {
                            setState(() {});
                          }),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            lis[index]['name']
                                                .toString()
                                                .toUpperCase(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25)),
                                                 Text(lis[index]['profession'],style: TextStyle(color: Colors.orange[800],fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),
                               
                                Divider(),
                                SizedBox(height: 10),
                                 Text('In Charge of districts:',style: TextStyle(color: Colors.red,fontSize: 15)),
                                   
                                Padding(
                                  padding: const EdgeInsets.only(top:10.0),
                                  child: Row(
                                    children: <Widget>[
                                     
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 10),
                                        margin: EdgeInsets.all(0),
                                        decoration:
                                            ut.rounded(Colors.red, false, 40),
                                        child: Text(
                                          lis[index]['district0'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 10),
                                        margin: EdgeInsets.all(0),
                                        decoration:
                                            ut.rounded(Colors.red, false, 40),
                                        child: Text(
                                          lis[index]['district1'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      lis[index]['localty'] +
                                          "," +
                                          lis[index]['district'],
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 16),
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
                                              launch("tel://" +
                                                  lis[index]['phone']);
                                            })),
                                  ],
                                )
                              ],
                            ),
                          )),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
