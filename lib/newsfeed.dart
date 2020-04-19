import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import './details.dart';
import 'utils.dart' as ut;


//Emergency newsfeed
class EmergencyGroupBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          height: 250.0,
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: Icon(Icons.local_hospital),
                title: Text("Emergency requirements"),
                backgroundColor: Colors.redAccent,
                floating: true,
                expandedHeight: 40,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.filter_list),
                      color: Colors.white,
                      onPressed: () {
                        return filterAlertDialog(context);
                      })
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  CarouselSlider(
                    scrollDirection: Axis.vertical,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    autoPlay: true,
                    pauseAutoPlayOnTouch: Duration(seconds: 10),
                    items: <Widget>[

                      
                                               EmergencyCard(
                          name1: "Carl Alex Johnny",
                          location1: "Calicut",
                          units1: "2",
                          hospital1: "MIMS Hospital",
                          group1: "A+",
                        ),

                      
                      
                                               EmergencyCard(
                          name1: "Mary Ann Jacob",
                          location1: "Calicut",
                          units1: "1",
                          hospital1: "Baby Memorial",
                          group1: "B+",
                        ),

                    ],
                  )
                ]),
              )
            ],
          )),
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
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                leading: Icon(Icons.opacity),
                title: Text(group),
                backgroundColor: Colors.redAccent,
                floating: true,
                expandedHeight: 40,
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.filter_list),
                      color: Colors.white,
                      onPressed: () {
                        return filterAlertDialog(context);
                      })
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate([

                  
                                       RequestCard(
                        name: "Shivani Sanjay",
                        location: "Calicut",
                        units: "5",
                        hospital: "PVS Hosptital"),

                  
                
                                       RequestCard(

                  
                        name: "Anjali Sanjay",
                        location: "Calicut",
                        units: "2",
                        hospital: "Iqra Hospital"),


                ]),
              )
            ],
          )),
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

  EmergencyCard(
      {@required this.name1,
      @required this.hospital1,
      @required this.location1,
      @required this.units1,
      @required this.group1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details()),
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

  RequestCard(
      {@required this.name,
      @required this.hospital,
      @required this.location,
      @required this.units});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Details()),
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
  NewsFeed({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ut.maintheme(),
          home: Scaffold(
          appBar: AppBar(
            leading:
                IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text("Newsfeed"),
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
              GroupBox(
                group: 'A+',
              ),
              GroupBox(
                group: 'A-',
              ),
              GroupBox(
                group: 'B+',
              ),
              GroupBox(
                group: 'B-',
              ),
              GroupBox(
                group: 'AB+',
              ),
              GroupBox(
                group: 'AB-',
              ),
              GroupBox(
                group: 'O+',
              ),
              GroupBox(
                group: 'O-',
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
