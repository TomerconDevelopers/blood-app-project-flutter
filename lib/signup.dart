import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'utils.dart' as ut;
import 'globals.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //textediting controllers for all fields
  TextEditingController fn = new TextEditingController();
  TextEditingController ln = new TextEditingController();
  TextEditingController mn = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController cn = new TextEditingController();
  TextEditingController acn = new TextEditingController();
  TextEditingController mail = new TextEditingController();
  TextEditingController ld = new TextEditingController();
  TextEditingController forTime = new TextEditingController();
  TextEditingController ft = new TextEditingController();
  TextEditingController un = new TextEditingController();
  TextEditingController pass = new TextEditingController();
  TextEditingController repass = new TextEditingController();

//required variables
  var t, r;
  Widget w = SizedBox(height: 10);
  String reg = "", sbg, st, gen, d, tl, p,m;
  var _key1 = GlobalKey<FormState>();
  List gender = ['Male', 'Female', 'Others'];
  bool checked = false;
  List status = ['Available anytime', 'Available for', 'Unavailable for'];
  List bloodgroup = ['A+', 'A-', 'O+', 'O-', 'B+', 'B-', 'AB+', 'AB-'];
  List med = [
    'None',
    'HIV',
    'Heart disease',
    'Hypertension',
    'Cancer',
    'Received Hepatitis B vaccine',
    'Major dental procedures/general surgeries in the past 1 month',
    'Fits',
    'Asthma',
    'Epilepsy',
    'Kidney ailments',
    'Diabetes',
    'Ear/body piercing/tatoo in past 6 months',
    'Undergone Immunization in the past 1 month',
    'Treated for rabies',
    'Pregnant/breast feeding',
    'Women undergone miscarriage in the past 6 months',
    'Tuberculosis',
    'Allergy to a substance used in blood donation/Severe allergy/unwell at the time of donation due to allergy'
  ];
  //list of districts
  List districts = [
    "Thiruvananthapuram",
    "Kollam",
    "Pathanamthitta",
    "Alappuzha",
    "Kottayam",
    "Idukki",
    "Ernakulam",
    "Thrissur",
    "Palakkad",
    "Malappuram",
    "Kozhikode",
    "Wayanad",
    "Kannur",
    "Kasargod"
  ];
  List l = [];
  //mapping districts to their taluks
  Map<String, List<String>> tlk = {
    "Thiruvananthapuram": [
      'Neyyattinkara',
      'Kattakada',
      'Nedumangadu',
      'Thiruvananthapuram',
      'Chirayankeezhu',
      'Varkala'
    ],
    "Kollam": [
      'Kollam',
      'Kunnathoor',
      'Karunagappally',
      'Kottarakara',
      'Punalur',
      'Pathanapuram'
    ],
    "Pathanamthitta": [
      'Adoor',
      'Konni',
      'Kozhencherry(HO:Pathanamthitta)',
      'Ranni',
      'Mallappally',
      'Thiruvalla'
    ],
    "Alappuzha": [
      'Chenganoor',
      'Mavelikara',
      'Karthikappally',
      'Kuttanad',
      'Ambalappuzha',
      'Cherthala'
    ],
    "Kottayam": [
      'Kottayam',
      'Vaikom',
      'Kanjirappally',
      'Meenachil',
      'Changanassery'
    ],
    "Idukki": ['Devikulam', 'Thodupuzha', 'Peermedu', 'Udumbanchola', 'Idukki'],
    "Ernakulam": [
      'Kanayannur',
      'Kochi',
      'Aluva',
      'Kunnathunad',
      'Kothamangalam',
      'Muvattupuzha',
      'Paravur'
    ],
    "Thrissur": [
      'Kodungallur',
      'Chavakkad',
      'Mukundapuram',
      'Thrissur',
      'Thalapilly',
      'Chalakudy',
      'Kunnamkulam'
    ],
    "Palakkad": [
      'Palakkad',
      'Chittur',
      'Alathoor',
      'Mannarkkad',
      'Ottappalam',
      'Pattambi'
    ],
    "Malappuram": [
      'Perinthalmanna',
      'Eranad',
      'Nilambur',
      'Tirur',
      'Ponnani',
      'Thiroorangadi',
      'Kondotty'
    ],
    "Kozhikode": ['Kozhikode', 'Koilandy', 'Vadakara', 'Thamarassery'],
    "Wayanad": ['Mananthavady', 'Vythiri', 'Sulthan Bathery'],
    "Kannur": ['Taliparamba', 'Thalassery', 'Kannur', 'Iritty', 'Payyannur'],
    "Kasargod": ['Hosdurg', 'Vellarikundu', 'Manjeshwaram', 'Kasaragod']
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        //upper beizer curved container
        decoration: BoxDecoration(
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop),
                image: AssetImage('images/bg.png'),
                fit: BoxFit.cover)),
        child: Scrollbar(
          child: ListView(
            children: <Widget>[
              ClipPath(
                clipper: ClippingClass(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.red, Colors.orange, Colors.yellow],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 30,
                            ),
                            Icon(
                              Icons.view_headline,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0, left: 20),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'To our family',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    autovalidate: true,
                    key: _key1,
                    child: ListView(
                      children: <Widget>[
                        TextFormField(
                          //first name
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter name';
                            } else {
                              return null;
                            }
                          },
                          controller: fn,
                          style: TextStyle(fontSize: 20),

                          decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          //last name
                          controller: ln,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          //middle name
                          controller: mn,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Middle Name',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //gender dropdown
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Field required...' : null,
                          hint: Text('Choose gender',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          items: gender.map((lisVal) {
                            return DropdownMenuItem<String>(
                              value: lisVal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(lisVal,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),Divider(),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              this.gen = val;
                            });
                          },
                          value: this.gen,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //age field
                        TextFormField(
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Please enter age';
                            } else {
                              return null;
                            }
                          },
                          controller: age,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Age',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20),
                            hintText: 'Between 18 and 65',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //weight field
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter your Weight';
                            } else {
                              return null;
                            }
                          },
                          controller: weight,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Weight(in Kg)',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20),
                              hintText: 'Should be 50 or above'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //blood group dropdown
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Field required...' : null,
                          hint: Text('Choose Blood group',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          items: bloodgroup.map((lisVal) {
                            return DropdownMenuItem<String>(
                              value: lisVal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(lisVal,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),Divider()
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              this.sbg = val;
                            });
                          },
                          value: this.sbg,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //district selector
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Field required...' : null,
                          hint: Text('Choose District',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          items: districts.map((lisVal) {
                            return DropdownMenuItem<String>(
                              value: lisVal,
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(lisVal,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),Divider()
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              this.d = val;
                              l = tlk[d];
                            });
                            tl = null;
                          },
                          value: this.d,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //taluk selector
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Field required...' : null,
                          hint: Text('Choose Taluk',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          items: l.map((lisVal) {
                            return DropdownMenuItem<String>(
                              value: lisVal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(lisVal,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),Divider()
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              this.tl = val;
                              print(tl);
                            });
                          },
                          value: this.tl,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //contact number
                        TextFormField(
                          validator: (value) {
                            var potentialNum = int.tryParse(value);
                            if (potentialNum == null) {
                              return 'Please enter a valid contact number';
                            } else {
                              return null;
                            }
                          },
                          controller: cn,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Contact number',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //alternate contact number
                        TextFormField(
                          validator: (value) {
                            if (value.isNotEmpty && value.length != 10) {
                              return 'Please enter a valid contact number';
                            } else {
                              return null;
                            }
                          },
                          controller: acn,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Alternate Contact number',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //email
                        TextFormField(
                          controller: mail,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //last donated
                        TextFormField(
                          controller: ld,
                          keyboardType: TextInputType.datetime,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            labelText: 'Last Donated on',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 20),
                            hintText: 'YYYY-MM-DD',
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //status-available or unavailable
                        DropdownButtonFormField<String>(
                          isExpanded: true,
                          validator: (value) =>
                              value == null ? 'Field required...' : null,
                          hint: Text('Choose Status',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                          items: status.map((lisVal) {
                            return DropdownMenuItem<String>(
                              value: lisVal,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(lisVal,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20)),Divider()
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (String val) {
                            setState(() {
                              this.st = val;
                              if (st != status[0]) {
                                w = callFor();
                              } else {
                                w = SizedBox(height: 10);
                              }
                            });
                          },
                          value: this.st,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        w, //if available for/unavailable for till when its valid
                        
                          
                              DropdownButtonFormField<String>(
                                                              isExpanded:true,
                                validator: (value) =>
                                    value == null ? 'Field required...' : null,
                                hint: Text('Do you have any of the medical conditions given?',
                                    style:
                                        TextStyle(color: Colors.black, fontSize: 20)),
                                items: med.map((lisVal) {
                                  return DropdownMenuItem<String>(
                                    value: lisVal,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(lisVal,
                                            style: TextStyle(
                                                color: Colors.black, fontSize: 20)),
                                                Divider(),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                onChanged: (String val) {
                                  setState(() {
                                    this.m = val;
                                    
                                  });
                                },
                                value: this.m,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //username
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a username';
                            } else {
                              return null;
                            }
                          },
                          controller: un,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //password
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter the password';
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          controller: pass,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty || value != pass.text) {
                              return "Passwords don't match";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          controller: repass,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 20)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Checkbox(
                                  value: checked,
                                  onChanged: (bool val) {
                                    setState(() {
                                      checked = val;
                                    });
                                  }),
                            ),
                            //agreement
                            Expanded(
                              flex: 10,
                              child: Text(
                                  "I hereby declare that information furnished above is true to the best of my knowledge.If any of the above information is found to be wrong,I will be solely responsible for anything resulting out of it and any loss or damage sustained to the government/any other person/agency.",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            ),
                          ],
                        ),
                        //button
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: RaisedButton(
                            disabledColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: Colors.redAccent,
                            onPressed: () {
                              if (checked) {
                                callIt(); //only if checked
                              }
                            },
                            child: Text(
                              'Sign up',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
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
            int.parse(age.text) > 65 || m!='None'){
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Sorry,You're not eligible to register",
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  contentPadding: EdgeInsets.all(20),
                );
              });
          //checks if dropdowns are empty or not
        } else if (sbg == null ||
            d == null ||
            tl == null ||
            gen == null ||
            st == null) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Text("Please fill all the required details",
                      style: TextStyle(fontSize: 30, color: Colors.red)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  contentPadding: EdgeInsets.all(20),
                );
              });
        }
        //if every data is available post details
        else {
          postData();
        }
      }
    });
  }
  //to set username and password
  setPrefs()async{
    SharedPreferences sp=await SharedPreferences.getInstance();
    Future<bool> u=sp.setString("uname",un.text);
    print(u);
    Future<bool> pa=sp.setString("pass",p);
    print(pa);

  }
  //posts data to the server
  postData() async {
    String fullName = fn.text + " " + mn.text + " " + ln.text;
    String g = gen.toLowerCase();
    p = ut.encrypt(pass.text);
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
            content: Text(
              reg,
              style: TextStyle(fontSize: 30, color: Colors.purpleAccent),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            contentPadding: EdgeInsets.all(20),
          );
        });
  }
//function to display the widget based on status
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
        labelText: 'Status active till',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
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
}
