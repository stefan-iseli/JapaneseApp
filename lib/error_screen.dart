import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorScreen extends StatelessWidget {
  final String myErrorMessage;
  ErrorScreen(this.myErrorMessage);

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
            "ステファンの日本語",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: new Text(myErrorMessage),
        ),
      ),
    );
  }
}
