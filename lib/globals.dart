// File for holding global variables
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

String app_name = "revive";
String app_version = "0.01-a";
String baseurl = "http://vps001.qubehost.com/bloodapp/"; //Need to update after setup server
Color prim_color = Colors.red[400];//Color for appbar
String bg_image = "assets/images/bg.png";//background image for all pages
String cu_id;

class UserLocationTracker {

  void getCurrentUserLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
  }
} //import this class for current user location. 
