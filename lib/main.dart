// import flutter packages (pub.dev for a list of available extensions)
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:flutter_tts/flutter_tts.dart';
//import 'package:flip_card/flip_card.dart';
//import 'package:google_fonts/google_fonts.dart';
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
import 'package:japaneseapp/login_page.dart';

void main() {
  print('main: BoJ - initializing Firebase');
  WidgetsFlutterBinding.ensureInitialized();
  print('running myApp');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      return Container(
          alignment: Alignment.center,
          child: new Text('Initialize Firebase: Something went wrong'));
    }
    if (!_initialized) {
      return Container(
          alignment: Alignment.center,
          child: new Text('Initialize Firebase: connecting ...'));
    }
    return LoginPage();
  }
}
