import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals.dart';
import 'package:encrypt/encrypt.dart' as en;

void showtoast(String text, Color col) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: col,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
ThemeData maintheme(){
  return ThemeData(
    // Define the default brightness and colors.
      brightness: Brightness.light,
      primaryColor: prim_color,
      accentColor: prim_color,

      // Define the default font family.
      fontFamily: 'Montserrat',

      // Define the default TextTheme. Use this to specify the default
      // text styling for headlines, titles, bodies of text, and more.
      textTheme: TextTheme(
        headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
        title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
        body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        subtitle: TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
      ));
}
Widget logo(){
  return new Image.asset(
    'assets/images/logo.png',
    width: 140.0,
    height: 140.0,
    fit: BoxFit.fill,
  );
}
//For rounded borders
BoxDecoration rounded(var col,bool bord,double r){
  return BoxDecoration(
    color: col,
    borderRadius: BorderRadius.circular(r),
    border: Border.all(
        color: (bord)?Colors.grey:Colors.transparent, style: BorderStyle.solid,
        width: 0.80),
  );
}
//For display app info dialog
displayinfo(State m) async {

  //HIDE KEYBOARD
  //SystemChannels.textInput.invokeMethod('TextInput.show');
  return showDialog(
      context: m.context,
      builder: (context) {
        return AlertDialog(

          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image.asset('images/logo.png', width: 140.0, height: 50.0, fit: BoxFit.cover,),
                Text("Version: $app_version"),
                Divider(),
                Text("Developed by: Tomercon Developers"),
                Divider(),
                new FlatButton(
                  child: new Text('HELP & SUPPORT'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text('CLOSE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      });
}
roundicon(var icn,Color icc,Color bg,double size,double pad)=>
    Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(pad),
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
      ),
      child: Icon(icn,size:size,color: icc),
    );
//for rounded text
roundedtext(String txt,Color bgcol,Color txtcol)=>
    Container(
      padding: EdgeInsets.symmetric(vertical:3,horizontal: 10),
      margin: EdgeInsets.all(0),
      decoration: rounded(bgcol,false,40),
      child: Text(txt,style: TextStyle(color: txtcol,fontSize: 14),),
    );
BoxDecoration bg(){
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey[300]]),
      image: DecorationImage(
        image: AssetImage(bg_image),fit: BoxFit.cover,
        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
      ));
}
//============ ENCRYPT-DECRYPT STRING ============
final key = en.Key.fromUtf8('my 32 length key................');
final iv = en.IV.fromLength(16);
final encrypter = en.Encrypter(en.AES(key));
String encrypt(String txt){
  print(iv.base64);
  final encrypted = encrypter.encrypt(txt, iv: iv);
  return encrypted.base64;
}
String decrypt(txt){
  print(iv.base64);
  final decrypted = encrypter.decrypt(en.Encrypted.fromBase64(txt), iv: iv);
  return decrypted;
}
//=============================================
//Widget for displaying empty list or empty items.
Widget empty_server(String txt){
  return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.info,size: 50,color: Colors.white,),
          Text('$txt',style: TextStyle(fontSize: 20,
              fontWeight: FontWeight.w600,color: Colors.blue[800]),)
        ],

      )
  );
}
