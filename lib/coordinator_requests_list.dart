import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'globals.dart' as g;
import 'package:flutter/material.dart';
import 'package:revive/Coordinator%20Request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;

class RequestList extends StatefulWidget {
  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  List lis = [];
  Future<List> getData() async {
    final SharedPreferences spp=await SharedPreferences.getInstance();
    String location=spp.getString('location');
    final res = await http.post(
       g.baseUrl+"/request_list.php",
        body: jsonEncode({"loc": location}));
    print(res.statusCode);
    return jsonDecode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ut.maintheme(),
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text('Request List'),
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios),
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
                          return ListTile(
                            leading: Icon(Icons.invert_colors),
                            title: Text(lis[index]['name']),
                            subtitle: Row(
                              children: <Widget>[
                                Text(lis[index]['bloodgroup']),
                                Text(lis[index]['hospital']),
                              ],
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BloodRequestDetails(
                                        name: lis[index]['name'],
                                        age: lis[index]['age'],
                                        date: lis[index]['date'],
                                        district: lis[index]['district'],
                                        taluk: lis[index]['taluk'],
                                        hospital: lis[index]['hospital'],
                                        group: lis[index]['bloodgroup'],
                                        number: lis[index]
                                            ['bystander_contacts'],
                                        altNumber: lis[index]
                                            ['bystander_alt_contacts'],
                                        units: lis[index]['bloodqty'],
                                      )),
                            ).then((var value) {
                                
                              
                                setState(() {
                                  
                                });
                            }),
                          );
                        });
                  }
                }),
          ),
        ));
  }
}
