import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

//importing own library
import 'package:japaneseapp/drawer.dart';

class Profile extends StatelessWidget {
  final User _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(
          "ステファンの日本語",
          style: GoogleFonts.tangerine(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: showMenuDrawer(context),
      body: _listProfile(),
    );
  }

  Widget _listProfile() {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
      child: Column(
        children: <Widget>[
          new ListTile(
            leading: Icon(Icons.email_outlined),
            title: new Text('Email/Id:'),
            trailing: new Text(_user.email),
          ),
          new ListTile(
            leading: Icon(Icons.verified),
            title: new Text('Email verified:'),
            trailing:
                new Text((_user.emailVerified) ? 'verified' : 'not verified'),
          ),
          new ListTile(
            leading: Icon(Icons.verified),
            title: new Text('Name:'),
            trailing: new Text(_user.displayName),
          ),
        ],
      ),
    );
  }
}
