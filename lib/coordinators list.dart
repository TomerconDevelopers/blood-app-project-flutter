import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
    final res = await http.get(
       g.baseUrl+"/coordinator_list.php");
    print(res.statusCode);
    return jsonDecode(res.body);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ut.maintheme(),
      home: Scaffold(
        appBar: AppBar(title: Text('Coordinators'),
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
                builder: (BuildContext context,
                    AsyncSnapshot<List<dynamic>> snapshot) {
                  lis = snapshot.data;
                  if (!snapshot.hasData) {
                    return Center(child:SpinKitHourGlass(color:Colors.red,size:80,),);
                  } else {
                    return ListView.builder(
                        itemCount: lis?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              ListTile(
                                leading: Icon(Icons.invert_colors,color: Color(0xFFFB415B),),
                                title: Text(lis[index]['name'],style:TextStyle(fontSize: 20),),
                                subtitle: Row(
                                  children: <Widget>[
                                    Text(lis[index]['localty']+",",style:TextStyle(fontSize: 17)),
                                    Text(lis[index]['district'],style:TextStyle(fontSize: 17)),
                                  ],
                                ),
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
                                            profession: lis[index]
                                                ['profession'],
                                           id:lis[index]['userid'],
                                          )),
                                ).then((var value) {
                                    
                                  
                                    setState(() {
                                      
                                    });
                                }),
                              ),
                              Divider(indent: 20,endIndent: 20,),
                            ],
                          );
                        });
                  }
                }),
        ),
    );
  }
}