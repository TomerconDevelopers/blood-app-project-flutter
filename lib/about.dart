import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Scaffold(
    backgroundColor: Colors.pink[50],
    appBar: AppBar(
      title: Text('ABOUT THE APP'),
      centerTitle: true,
      backgroundColor: Colors.red[400],
    ),
    body: Center(
      child: Text(
        'Revive is an open source project started under Tomercon Developers in the idea of providing an online platform for the communication between blood donors and acceptors. We aim to provide a user friendly interface which facilitates the communication , resulting in an improved facility to address the needs of patients in need of blood donations. Donors will be able to search for patients in need according to their given locations and other details , and will be provided contact details of the by-stander of the respective patient. They will also have the privilage to mark themselves as unavailable if they are not available at the moment , or if they have already made a blood donation recently. Notifications will be available to the available donors including emergency cases where donation is required urgently',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        ),
    ),
  )
));