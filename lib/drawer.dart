// importing google platform packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//importing own library
import 'package:japaneseapp/kanji.dart';
import 'package:japaneseapp/dictionary.dart';
import 'package:japaneseapp/phrases.dart';

Widget showMenuDrawer(BuildContext context) {
  return Drawer(
    child: new ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
            margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            padding: EdgeInsets.all(20.0),
            duration: Duration(seconds: 2),
            curve: Curves.bounceInOut,
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Stack(children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    icon: Icon(Icons.close, size: 30, color: Colors.white),
                    onPressed: () => Navigator.pop(context)),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 35,
                    backgroundImage: AssetImage(
                      'assets/TwitterLogo.ppng',
                    ),
                  )),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Menu',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  FirebaseAuth.instance.currentUser.displayName,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.lerp(
                    Alignment.centerRight, Alignment.bottomRight, 0.5),
                child: Text(
                  FirebaseAuth.instance.currentUser.email,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ])),
        ListTile(
          leading: Icon(Icons.brush),
          title: Text('Kanji - focus to remember Kanji'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Kanji(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.library_books),
          title: Text('Dictionary - focus to learn vocabulary'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Dictionary(),
              ),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text('Phrases - typical Japanese phrases to remember'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Phrases(),
              ),
            );
          },
        ),
        Divider(
          color: Colors.grey[300],
          height: 15.0,
          thickness: 3.0,
          indent: 5.0,
          endIndent: 5.0,
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text('Profile/Account'),
          onTap: () {
            print('Profile is under construction');
          },
        ),
        Divider(
          color: Colors.grey[500],
          height: 15.0,
          thickness: 5.0,
          indent: 5.0,
          endIndent: 5.0,
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Exit - Exit to login page'),
          onTap: () {
            print('exit exit exit pressed');
          },
        ),
      ],
    ),
  );
}