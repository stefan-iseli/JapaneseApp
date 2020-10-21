// importing google platform packages
//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

import 'package:flutter/material.dart';

// importing own packages/modules
import 'package:japaneseapp/show_dialog.dart';
import 'package:japaneseapp/email_sign_in.dart';
import 'package:japaneseapp/global.dart' as global;

// Sign up class
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String _inputUser;
  String _inputPW;
  String _inputDisplayName;
  String _inputPhotoURL;

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
              _signUpData(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signUpData() {
    return Column(
      children: <Widget>[
        new Container(
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                new TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      isDense: true,
                      labelText: 'User Id (email)*:',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return ('please enter a User Id');
                      } else {
                        setState(() => {_inputUser = value.trim()});
                        return null;
                      }
                    }),
                new TextFormField(
                  obscureText: (global.myVisibility) ? false : true,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: (global.myVisibility)
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () => {
                        setState(
                          () {
                            (global.myVisibility)
                                ? global.myVisibility = false
                                : global.myVisibility = true;
                          },
                        ),
                      },
                    ),
                    isDense: true,
                    labelText: 'Password *:',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return ('please enter a password');
                    } else {
                      setState(() => {_inputPW = value});
                      return null;
                    }
                  },
                ),
                new TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_add_outlined),
                      isDense: true,
                      labelText: 'Name *:',
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return ('please enter your full name');
                      } else {
                        setState(() => {_inputDisplayName = value});
                        return null;
                      }
                    }),
                new TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.picture_in_picture_rounded),
                      isDense: true,
                      labelText: 'Photo URL/Avatar:',
                    ),
                    validator: (String value) {
                      if (value.isNotEmpty) {
                        setState(() => {_inputPhotoURL = value});
                      } else {
                        setState(
                            () => {_inputPhotoURL = 'assets/TwitterLogo.png'});
                      }
                      return null;
                    }),
              ],
            ),
          ),
        ),
        new Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0.0),
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: SizedBox(
            height: 40,
            width: 200,
            child: FlatButton(
              color: Colors.yellow,
              highlightColor: Colors.purple,
              textColor: Colors.black,
              child: new Text('Sign-up now!', style: TextStyle(fontSize: 26)),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  emailSignInService
                      .signUpWithEmail(context, _inputUser, _inputPW,
                          _inputDisplayName, _inputPhotoURL)
                      .then(
                    (result) {
                      if (result != null) {
                        return showMyDialog(
                            context, 'sign-up', 'new user created', _inputUser);
                      } else {
                        if (global.myErrorMessage = null) {
                          return showMyDialog(context, 'sign-up',
                              'failed to create new user', _inputUser);
                        } else {
                          return showMyDialog(
                              context,
                              'sign-up',
                              'falied to create new user',
                              global.myErrorMessage);
                        }
                      }
                    },
                  );
                }
              },
            ),
          ),
        ),
        new Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: SizedBox(
            height: 40,
            width: 200,
            child: FlatButton(
              color: Colors.grey,
              highlightColor: Colors.purple,
              textColor: Colors.black,
              child: new Text('back', style: TextStyle(fontSize: 26)),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
