import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as g;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
import 'package:koukicons/report.dart';
import 'package:koukicons/share2.dart';
import 'package:koukicons/comments.dart';
import 'package:koukicons/callback.dart';
import 'package:koukicons/businessman.dart';

class DonorList extends StatefulWidget {
  final String dis, tal, bg;
  DonorList({Key key, this.dis, this.tal, this.bg}) : super(key: key);
  @override
  _DonorListState createState() => _DonorListState(this.dis, this.tal, this.bg);
}

class _DonorListState extends State<DonorList> {
  int _grp;
  List lis = [];
  String dis, tal, bg, _txt = '';
  _DonorListState(String d, String t, String b) {
    this.dis = d;
    this.tal = t;
    this.bg = b;
  }
  Widget w = SizedBox(
    width: 1,
  );
  TextEditingController un = TextEditingController();

  Future<List> getData() async {
    var bd = jsonEncode({"district": dis, "taluk": tal, "group": bg});
    final res = await http.post(
        // g.baseUrl+
        g.baseUrl + "/donor_list1.php",
        body: bd);
    print(res.statusCode);
    return jsonDecode(res.body);
  }

  @override
  void initState() {
    _grp = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
      home: Scaffold(
        backgroundColor: Colors.orange[50],
        appBar: AppBar(
          title: Text('Donors List'),
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
                                  Text(
                                        lis[index]['name']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Last Donated on: " +
                                          lis[index]['last_don'],
                                      style: TextStyle(
                                          color: Colors.blue[900],
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    lis[index]['status'] == 'Unavailable for'
                                        ? Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 10),
                                            margin: EdgeInsets.all(0),
                                            decoration: ut.rounded(
                                                Colors.red, false, 40),
                                            child: Text(
                                              lis[index]['status'] +
                                                        " upto " +
                                                        lis[index]['for_time'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        : Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 3, horizontal: 10),
                                            margin: EdgeInsets.all(0),
                                            decoration: ut.rounded(
                                                Colors.green, false, 40),
                                            child: lis[index]['status'] ==
                                                    'Available anytime'
                                                ? Text(
                                                    lis[index]['status'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Text(
                                                    lis[index]['status'] +
                                                        " upto " +
                                                        lis[index]['for_time'],
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                        lis[index]['bloodgroup'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
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
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[100],
                                        child: IconButton(
                                            icon: KoukiconsCallback(),
                                            onPressed: () {
                                              launch("tel://" +
                                                  lis[index]['contacts']);
                                            })),
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[100],
                                        child: IconButton(
                                            icon: KoukiconsComments(),
                                            onPressed: () {
                                              launch("sms:" +
                                                  lis[index]['contacts']);
                                            })),
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[100],
                                        child: IconButton(
                                            icon: KoukiconsShare2(),
                                            onPressed: () {
                                              Share.share("Name:" +
                                                  lis[index]['name'] +
                                                  "\nContacts:" +
                                                  lis[index]['contacts'] +
                                                  "\nLocation:" +
                                                  lis[index]['localty'] +
                                                  "," +
                                                  lis[index]['district']);
                                            })),
                                    CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey[100],
                                        child: IconButton(
                                            icon: KoukiconsReport(),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            actions: <Widget>[
                                                              FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    _txt = _grp ==
                                                                            4
                                                                        ? un.text
                                                                        : _txt;
                                                                    print(_txt);
                                                                    launch('mailto:tomercondeveloper@gmail.com?subject=' +
                                                                        _txt +
                                                                        '&body=' +
                                                                        lis[index]
                                                                            [
                                                                            'name'] +
                                                                        ' is reported with the issue of ' +
                                                                        _txt);
                                                                  },
                                                                  child: Text(
                                                                      'Report'))
                                                            ],
                                                            content: StatefulBuilder(
                                                                builder: (BuildContext
                                                                        context,
                                                                    setState) {
                                                              return Container(
                                                                height: 500,
                                                                width: double
                                                                    .maxFinite,
                                                                child: ListView(
                                                                  children: <
                                                                      Widget>[
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      child: Center(
                                                                        child: Text(lis[
                                                                                index]
                                                                            [
                                                                            'name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
                                                                      ),
                                                                    ),
                                                                   
                                                                    RadioListTile(
                                                                        title: Text(
                                                                            "Wrong number"),
                                                                        value:
                                                                            0,
                                                                        groupValue:
                                                                            _grp,
                                                                        onChanged:
                                                                            (val) {
                                                                          setState(
                                                                              () {
                                                                            _txt =
                                                                                "Wrong number";
                                                                            _grp =
                                                                                val;
                                                                            print(val);
                                                                          });
                                                                        }),
                                                                    Divider(),
                                                                    RadioListTile(
                                                                        title: Text(
                                                                            "Denied Request"),
                                                                        value:
                                                                            1,
                                                                        groupValue:
                                                                            _grp,
                                                                        onChanged:
                                                                            (val) {
                                                                          setState(
                                                                              () {
                                                                            _txt =
                                                                                "Denied Request";
                                                                            _grp =
                                                                                val;
                                                                            print(val);
                                                                          });
                                                                        }),
                                                                    Divider(),
                                                                    RadioListTile(
                                                                        title: Text(
                                                                            "Someone else is using"),
                                                                        value:
                                                                            2,
                                                                        groupValue:
                                                                            _grp,
                                                                        onChanged:
                                                                            (val) {
                                                                          setState(
                                                                              () {
                                                                            _txt =
                                                                                "Someone else is using";
                                                                            _grp =
                                                                                val;
                                                                            print(val);
                                                                          });
                                                                        }),
                                                                    Divider(),
                                                                    RadioListTile(
                                                                        title: Text(
                                                                            "Asked for money"),
                                                                        value:
                                                                            3,
                                                                        groupValue:
                                                                            _grp,
                                                                        onChanged:
                                                                            (val) {
                                                                          setState(
                                                                              () {
                                                                            _txt =
                                                                                "Asked for money";
                                                                            _grp =
                                                                                val;
                                                                            print(val);
                                                                          });
                                                                        }),
                                                                    Divider(),
                                                                    RadioListTile(
                                                                        title: Text(
                                                                            "Others"),
                                                                        value:
                                                                            4,
                                                                        groupValue:
                                                                            _grp,
                                                                        onChanged:
                                                                            (val) {
                                                                          setState(
                                                                              () {
                                                                            _grp =
                                                                                val;
                                                                            w = TextFormField(
                                                                              validator: (value) {
                                                                                if (value.isEmpty) {
                                                                                  return 'Field required';
                                                                                } else {
                                                                                  return null;
                                                                                }
                                                                              },
                                                                              controller: un,
                                                                              style: TextStyle(fontSize: 20),
                                                                              decoration: InputDecoration(
                                                                                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                                                                              ),
                                                                            );
                                                                            _txt =
                                                                                un.text;
                                                                          });
                                                                        }),
                                                                    _grp == 4
                                                                        ? w
                                                                        : SizedBox(
                                                                            width:
                                                                                2)
                                                                  ],
                                                                ),
                                                              );
                                                            }),
                                                          ));
                                            })),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )),
                      );
                    });
              }
            }),
      ),
    );
  }
}
