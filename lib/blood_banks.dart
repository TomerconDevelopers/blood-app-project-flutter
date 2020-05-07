import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:koukicons/callback.dart';
import 'package:koukicons/like.dart';
import 'package:koukicons/news.dart';
import 'package:mongo_dart/mongo_dart.dart' as mon;
import 'utils.dart' as ut;
import 'globals.dart' as g;
class BloodBanks extends StatefulWidget {
  @override
  _BloodBanksState createState() => _BloodBanksState();
}

class _BloodBanksState extends State<BloodBanks> {
     List<Map<String,dynamic>> banks = [];
     bool isloading=true;
     mon.Db db;
  initmon() async {
    db = new mon.Db(g.mongo_url);
    await db.open().then((val){print("$val");});
    load();
  } 
  
  void addtolist(Map a){
    setState(() {
      banks.add(a);
    });
    
  }
  load() async{
   var gallery = db.collection("bloodbanks");
   await gallery.find().forEach(addtolist).then((onValue){print(onValue);
    setState(() {
    
      isloading= false;
    });
    });   
  }
  asyncFunc(BuildContext) async {
   await initmon();
  }  
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => start(context));
  }
  void start(BuildContext){
    asyncFunc(BuildContext);
  }
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
        body: isloading? ut.loader(): Container(
          color: Colors.orange[50],
          padding: const EdgeInsets.only(top:10.0,bottom:20),
          child: ListView.builder(
            itemCount: banks.length,
            itemBuilder: (context,index){
              return 
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
                          Text("  "+banks[index]['name'].toString(),style: GoogleFonts.fugazOne(),)
                        ],),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            
                            children: <Widget>[
                            Icon(Icons.location_on,color: Colors.red,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("  "+banks[index]['location'].toString(),style: GoogleFonts.fugazOne(),),
                            )
                          ],),
                        ),
                        Row(children:[
                          KoukiconsCallback(color:Colors.red,height: 37,),
                          Text("  "+banks[index]['contact'].toString(),style: GoogleFonts.fugazOne(),)
                        ])
                      ]
                    ),
                  ) ,),
              );
            }
          ),
        ),
      ),
    );
  }
}
