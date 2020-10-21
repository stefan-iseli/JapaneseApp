import 'package:flutter/material.dart';
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
          new Container(
            child: new Text('Profile/Account',
                style: TextStyle(color: Colors.blue, fontSize: 24)),
            alignment: Alignment.center,
          ),
          new Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 2.0,
            color: Colors.blue,
          ),
          new ListTile(
            leading: Icon(Icons.email_outlined),
            title: new Text(_user.email),
          ),
          new ListTile(
            leading: Icon(Icons.fact_check),
            title: new Text((_user.emailVerified)
                ? 'Email is verified'
                : 'Email is not verified'),
          ),
          new ListTile(
            leading: Icon(Icons.tag_faces),
            title: new Text(_user.displayName),
          ),
          (_user.phoneNumber != null)
              ? new ListTile(
                  leading: Icon(Icons.contact_phone),
                  title: new Text(_user.phoneNumber))
              : new Container(),
          new ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              backgroundImage: NetworkImage(
                _user.photoURL,
              ),
            ),
            title: new Text(_user.photoURL),
          ),
          new Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 2.0,
            color: Colors.blue,
          ),
          new ListTile(
            leading: Icon(Icons.access_time),
            title: new Text(_user.metadata.lastSignInTime.toString()),
            trailing: new Text('last'),
          ),
          new ListTile(
            leading: Icon(Icons.access_time),
            title: new Text(_user.metadata.creationTime.toString()),
            trailing: new Text('since'),
          ),
          new Divider(
            indent: 10.0,
            endIndent: 10.0,
            thickness: 3.0,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
