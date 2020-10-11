// import flutter packages (pub.dev for a list of available extensions)
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:flutter_tts/flutter_tts.dart';
//import 'package:flip_card/flip_card.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:rxdart/rxdart.dart';

/*
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:async/async.dart';
import 'package:image/image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:geolocator/geolocator.dart';
import 'package:device_info/device_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
*/
// own flutter code files to be included
//import 'package:japaneseapp/...dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'japaneseapp',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue,
        accentColor: Colors.blueAccent,
        textTheme: GoogleFonts.notoSansTextTheme((Theme.of(context).textTheme)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: new Text(
            "Stefan's Japanese App",
            style: GoogleFonts.tangerine(
              fontSize: 36,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Container(
                child: new Text('Firestore authentication in error'),
                alignment: Alignment.center,
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                child: new Text('Firestore authentication succeeded'),
                alignment: Alignment.center,
              );
              //return MyLoginPage("Stefan's Japanese App");
            } else {
              return Container(
                child: new Text('Firestore connecting ...'),
                alignment: Alignment.center,
              );
              //return Errors('... connecting ...');
            }
          },
        ),
      ),
    );
  }
}
