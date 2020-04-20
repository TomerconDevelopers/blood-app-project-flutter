import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'utils.dart' as ut;
class BloodBanks extends StatefulWidget {
  @override
  _BloodBanksState createState() => _BloodBanksState();
}

class _BloodBanksState extends State<BloodBanks> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ut.maintheme(),
          home: Scaffold(
        appBar: AppBar(
          title: Text("Blood Banks in Kerala"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context)),
        ),
        body:Padding(
          padding: const EdgeInsets.only(top:20.0,bottom:20),
          child: ListView(
            children: <Widget>[
              ut.roundedtext("Medical College Hospital Blood Bank\nAlappuzha\n0477-2282709,BBMO -9446374886",Color(0xFFFB415B),Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
