/*
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditProfile extends StatefulWidget {
  EditProfile({this.userModel});
  final UserModel userModel;
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<EditProfile> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var _user = TextEditingController();
  var _phone = TextEditingController();
  String selectedValue;
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  String text = "Edit profile";
  String locationName = 'Location';
  bool index = true;
  bool isLoading = false;
  bool hiddenText = true;
  UserModel user = UserModel(
      id: "",
      name: "",
      blood: "",
      contact: "",
      longitude: 0,
      latitude: 0,
      email: "");
  static const blood = <String>['A+', 'A-', 'B+', 'B-', 'O+', 'O-'];
  final List<DropdownMenuItem<String>> _bloodgroups = blood
      .map(
        (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyle(
                    color: Colors.red,
                  )),
            ),
      )
      .toList();

  void _update() async {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();
    } else
      return;

    try {
      setState(() {
        isLoading = true;
      });

      await FirestoreProvider().updateUser(user);

      setState(() {
        index = true;
        isLoading = false;
      });
      Navigator.of(context).pop(context);
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackbar(err.message);
    }
  }

  showSnackbar(message) {
    _scaffoldkey.currentState.showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(message ?? "Something went wrong, try again later."),
    ));
  }

  @override
  void initState() {
    super.initState();
    if (widget.userModel != null) {
      _user.text = widget.userModel.name;
      _phone.text = widget.userModel.contact;
      selectedValue = widget.userModel.blood;
      locationName =
          "${widget.userModel.latitude},${widget.userModel.longitude}";
      setUser();
      user = widget.userModel;
    }
  }

  setUser() async {
    var userr = await FirebaseAuthProvider().getCurrentUser();
    user.id = userr.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff44130f),
      key: _scaffoldkey,
      body: BaseScreen(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(context),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                buildSignupForm()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildSignupForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: <Widget>[
          CustomTextField(
            textCapitalization: TextCapitalization.words,
            controller: _user,
            onSaved: (value) {
              user.name = value;
            },
            label: "Fullname",
            hint: "Ex: Marquees Brownlee",
            onValidate: (value) {
              if (value.isEmpty) return 'This field can\'t be empty';
            },
          ),
          SizedBox(
            height: 20,
          ),
          CustomTextField(
            controller: _phone,
            onSaved: (value) {
              user.contact = value;
            },
            onValidate: (value) {
              if (value.length != 10)
                return 'Phone Number must be of 10 digits';
              else if (value.isEmpty) return 'This field can\'t be empty';
            },
            label: 'Contact',
            hint: 'Ex:9880124587',
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            child: DropdownButtonFormField(
              value: selectedValue,
              hint: Text(
                'Blood Group',
                style: TextStyle(color: Colors.white),
              ),
              items: _bloodgroups,
              onChanged: ((String newvalue) {
                setState(() {
                  selectedValue = newvalue;
                  print(selectedValue);
                  user.blood = selectedValue;
                });
              }),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            height: 55,
            child: FlatButton(
              child: Text(locationName,
                  style: TextStyle(
                    color: Colors.white,
                  )),
              onPressed: () async {
                var loc = await Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Maps()));
                if (loc != null) {
                  setState(() {
                    locationName = "${loc.latitude},${loc.longitude}";
                  });
                  user.latitude = loc.latitude;
                  user.longitude = loc.longitude;
                }
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 90,
                child: ClipPolygon(
                  sides: 6,
                  rotate: 120,
                  borderRadius: 9.0,
                  child: Container(
                    color: Colors.red,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.yellow)))
                        : IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            onPressed: _update,
                          ),

                  ),
                ),
              ),
            ],
          ),




      ),
    );
  }


  callIt() {
    setState(() {
      //checking weight and age
      if (_key1.currentState.validate()) {
        if (int.parse(weight.text) < 50 ||
            int.parse(age.text) < 18 ||
            int.parse(age.text) > 65) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Sorry,You're not eligible to register",style: TextStyle(fontSize: 30,color: Colors.red)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  contentPadding: EdgeInsets.all(20),
                );
              });
              //checks if dropdowns are empty or not
        }
         else {
           postData();
        }
      }
    });
  }
  //to set username and password
  setPrefs()async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    Future<bool> u=sp.setString("username",un.text);
    print(u);
    Future<bool> pa=sp.setString("password",p);
    print(pa);

  }
  postData() async {
    String fullName = fn.text + " " + mn.text + " " + ln.text;
    String g = gen.toLowerCase();
    p=ut.encrypt(pass.text);
    await setPrefs();
    var bd = json.encode({
      "name": fullName,
      "gender": g,
      "age": age.text,
      "weight": weight.text,
      "bloodgroup": sbg,
      "district": d,
      "localty": tl,
      "contacts": cn.text,
      "alt_contact": acn.text,
      "email": mail.text,
      "last_don": ld.text,
      "status": st,
      "for_time": forTime.text,
      "uname": un.text,
      "password": p
    });
    var res = await http.post(
        baseurl+"/signup.php",
        body: bd);
    print(res.statusCode);
    reg = jsonDecode(res.body);
    print(res.body);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(reg,style: TextStyle(fontSize: 30,color: Colors.purpleAccent),),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            contentPadding: EdgeInsets.all(20),
          );
        });
  }

  Widget callFor() {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return "Please enter the time upto which status is active";
        } else {
          return null;
        }
      },
      controller: forTime,
      keyboardType: TextInputType.datetime,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        labelText: 'Status active till',labelStyle:
                                TextStyle(color: Colors.black, fontSize: 25,),
        hintText: 'YYYY-MM-DD',
      ),
    );
  }
}
// to clip the path
class ClippingClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;

  showErrorDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content:
                  Text('Enter the fields', style: TextStyle(color: Colors.red)),
              actions: <Widget>[
                FlatButton(
                  child: Text('ok'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
              title: Text('Error'));
        });
  }

}
*/

