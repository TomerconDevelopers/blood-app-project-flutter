import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:koukicons/callback.dart';
import 'package:koukicons/like.dart';
import 'package:koukicons/news.dart';
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
        body:Container(
          color: Colors.orange[50],
          padding: const EdgeInsets.only(top:10.0,bottom:20),
          child: ListView(
            children: <Widget>[
              Container(
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(19)),
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child:Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:[
                        Row(children: <Widget>[
                          KoukiconsNews(),
                          Text("  Medical College Hospital Blood Bank",style: GoogleFonts.fugazOne(),)
                        ],),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            
                            children: <Widget>[
                            Icon(Icons.location_on,color: Colors.red,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("  Alapuzha",style: GoogleFonts.fugazOne(),),
                            )
                          ],),
                        ),
                        Row(children:[
                          KoukiconsCallback(color:Colors.red),
                          Text(" 0477-2282709,BBMO -9446374886",style: GoogleFonts.fugazOne(),)
                        ])
                      ]
                    ),
                  ) ,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
