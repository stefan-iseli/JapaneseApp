// import flutter packages (pub.dev for a list of available extensions)
import 'package:flutter/material.dart';
import 'package:japaneseapp/kanji.dart';

// own flutter code files to be inclueded
import 'package:japaneseapp/google_sign_in.dart';
import 'package:japaneseapp/user_credentials.dart';
import 'package:japaneseapp/global.dart' as global;
import 'package:japaneseapp/show_dialog.dart';
import 'package:japaneseapp/sign_up.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              _signUpButton(),
            ],
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
          setState(() {
            global.myLoginMethod = 'Email';
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserCredentials(),
            ),
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
                color: Colors.white,
                size: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with your Id',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
          googleSignInService.signInWithGoogle().then(
            (result) {
              if (result != null) {
                setState(
                  () {
                    global.myLoginMethod = 'Google';
                  },
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Kanji(),
                  ),
                );
              } else {
                showMyDialog(context, 'Google sign-in', 'Sign-in failed',
                    'try again or try another option');
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
            onPressed: () => {
              setState(() => {global.myLoginMethod = 'Email'}),
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                ),
              ),
            },
          ),
        ],
      ),
    );
  }
}
