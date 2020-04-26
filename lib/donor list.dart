import 'package:flutter/material.dart';
import 'utils.dart' as ut;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as g;
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

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
              if (snapshot.hasError) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                    itemCount: lis?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ExpansionTile(
                            leading: Icon(
                              Icons.invert_colors,
                              color: Color(0xFFFB415B),
                            ),
                            title: Text(
                              lis[index]['name'],
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(lis[index]['contacts'] + ",",
                                style: TextStyle(fontSize: 16)),
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.phone),
                                    onPressed: () {
                                      launch("tel://" + lis[index]['contacts']);
                                    },
                                    color: Color(0xFFFB415B),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.message),
                                    onPressed: () {
                                      launch("sms:" + lis[index]['contacts']);
                                    },
                                    color: Color(0xFFFB415B),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () {
                                      Share.share("Name:" +
                                          lis[index]['name'] +
                                          "\nContacts:" +
                                          lis[index]['contacts']);
                                    },
                                    color: Color(0xFFFB415B),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.report),
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        _txt=_grp==4?un.text:_txt;print(_txt);
                                                        launch(
                                                          'mailto:tomercondeveloper@gmail.com?subject=' +
                                                              _txt +
                                                              '&body=' +
                                                              lis[index]
                                                                  ['name'] +
                                                              ' is reported with the issue of ' +
                                                              _txt);},
                                                      child: Text('Report'))
                                                ],
                                                content: StatefulBuilder(
                                                    builder:
                                                        (BuildContext context,
                                                            setState) {
                                                  return Container(
                                                    height: 500,
                                                    width: double.maxFinite,
                                                    child: ListView(
                                                      children: <Widget>[
                                                        Text(
                                                            lis[index]['name']),
                                                        Divider(),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Wrong number"),
                                                            value: 0,
                                                            groupValue: _grp,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                _txt =
                                                                    "Wrong number";
                                                                _grp = val;
                                                                print(val);
                                                              });
                                                            }),
                                                        Divider(),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Denied Request"),
                                                            value: 1,
                                                            groupValue: _grp,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                _txt =
                                                                    "Denied Request";
                                                                _grp = val;
                                                                print(val);
                                                              });
                                                            }),
                                                        Divider(),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Someone else is using"),
                                                            value: 2,
                                                            groupValue: _grp,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                _txt =
                                                                    "Someone else is using";
                                                                _grp = val;
                                                                print(val);
                                                              });
                                                            }),
                                                        Divider(),
                                                        RadioListTile(
                                                            title: Text(
                                                                "Asked for money"),
                                                            value: 3,
                                                            groupValue: _grp,
                                                            onChanged: (val) {
                                                              setState(() {
                                                                _txt =
                                                                    "Asked for money";
                                                                _grp = val;
                                                                print(val);
                                                              });
                                                            }),
                                                        Divider(),
                                                        RadioListTile(
                                                            title:
                                                                Text("Others"),
                                                            value: 4,
                                                            groupValue: _grp,
                                                            onChanged: (val) {
                                                              setState(() {
                                                               
                                                                _grp = val;
                                                                w = TextFormField(
                                                                  validator:
                                                                      (value) {
                                                                    if (value
                                                                        .isEmpty) {
                                                                      return 'Field required';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                  controller:
                                                                      un,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                  decoration: InputDecoration(
                                                                      
                                                                      enabledBorder: UnderlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              color: Colors
                                                                                  .black)),
                                                                      ),
                                                                );
                                                                 _txt =un.text;
                                                              });
                                                            }),
                                                       _grp==4? w:SizedBox(width:2)
                                                      ],
                                                    ),
                                                  );
                                                }),
                                              ));
                                    },
                                    color: Color(0xFFFB415B),
                                  ),
                                ],
                              )
                            ],
                          ),
                          //Divider(indent: 20,endIndent: 20,),
                        ],
                      );
                    });
              }
            }),
      ),
    );
  }
}
