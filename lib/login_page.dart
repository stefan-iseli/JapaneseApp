// import flutter packages (pub.dev for a list of available extensions)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// own flutter code files to be inclueded
import 'package:japaneseapp/sign_in.dart';
import 'package:japaneseapp/first_screen.dart';
import 'package:japaneseapp/error_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/JapaneseBackground.PNG'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _emailSignInButton(),
                _googleSignInButton(),
                _signInIconButton(),
                _signUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailSignInButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 20.0),
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          signInService.signInWithGoogle().then(
            (result) {
              if (result != null) {
                return FirstScreen();
              }
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(
            color: Colors.white, width: 2.0, style: BorderStyle.solid),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.email_outlined,
                color: Colors.blue[200],
                size: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with your Id',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue[200],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: OutlineButton(
        splashColor: Colors.grey,
        onPressed: () {
          signInService.signInWithGoogle().then(
            (result) {
              if (result != null) {
                return FirstScreen();
              }
            },
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        borderSide: BorderSide(
            color: Colors.greenAccent, width: 2.0, style: BorderStyle.solid),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.greenAccent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInIconButton() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 25.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'or sign-in with: ',
            style: TextStyle(color: Colors.blue[200], fontSize: 20),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () => {print('Twitter sign-in under construction')},
                child: Image(
                  image: AssetImage("assets/TwitterLogo.png"),
                  //color: Colors.blue,
                  height: 60,
                ),
              ),
              FlatButton(
                onPressed: () => print('Facebook sign-in under construction'),
                child: Image(
                  image: AssetImage("assets/FaceBookLogo.png"),
                  //color: Colors.blue,
                  height: 50,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _signUpButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 2.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'No account yet?',
            style: TextStyle(color: Colors.yellow, fontSize: 20),
          ),
          FlatButton(
            color: Colors.yellow,
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
            child: new Text('Sign-up now',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                )),
            onPressed: () => print('_signUpButton pressed'),
          ),
        ],
      ),
    );
  }
}
