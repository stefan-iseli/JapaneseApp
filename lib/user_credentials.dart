// import standard packages for flutter (pub.dev)
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:japaneseapp/email_sign_in.dart';

// include own flutter code files
import 'package:japaneseapp/global.dart' as global;
import 'package:japaneseapp/kanji.dart';

class UserCredentials extends StatefulWidget {
  UserCredentials();
  @override
  _UserCredentials createState() => new _UserCredentials();
}

class _UserCredentials extends State<UserCredentials> {
  final _formKey = GlobalKey<FormState>(); //key for input ID/PW
  String _inputUser;
  String _inputPW;

  Future<void> signInHandler() async {
    print('signInHandler: $_inputUser/$_inputPW');
    emailSignInService.signInWithEmail(_inputUser, _inputPW).then(
      (result) {
        if (result != null) {
          setState(
            () {
              global.myLoginMethod = 'Email';
            },
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Kanji(),
            ),
          );
        } else {
          print('Google sign-in failed');
          return Container(
            child: new Text('Google sign-in failed'),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/JapaneseBackground.PNG'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new TextFormField(
                        textCapitalization: TextCapitalization.none,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined),
                          labelText: 'User Id (email)',
                          border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              gapPadding: 4.0),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return ('Error: Missing User-Id (email)');
                          } else {
                            setState(() {
                              _inputUser = value.toLowerCase().trim();
                            });
                            return null;
                          }
                        },
                      ),
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
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(4.0)),
                                gapPadding: 4.0),
                          ),
                          validator: (String value) {
                            setState(
                              () {
                                _inputPW = value.trim();
                              },
                            );
                            return null;
                          }),
                      new Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                        margin: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 5.0),
                        child: SizedBox(
                          height: 40,
                          width: 350,
                          child: FlatButton(
                            child: const Text('Sign-in',
                                style: TextStyle(fontSize: 20)),
                            color: Colors.blue,
                            highlightColor: Colors.deepPurple,
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                print(
                                    '_UserCredentials = $_inputUser/$_inputPW');
                                print(
                                    '_UserCredentials: calling signInHandler');
                                signInHandler();
                                print('_UserCredentials: signInHandler return');
                              }
                            },
                          ),
                        ),
                      ),
                      new Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            flex: 4,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                              child: SizedBox(
                                child: FlatButton(
                                  child: const Text('new password?',
                                      style: TextStyle(fontSize: 16)),
                                  color: Colors.grey,
                                  highlightColor: Colors.deepPurple,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    print('userCredentials: new PW requested');
                                    if (_formKey.currentState.validate()) {
                                      print(
                                          'userCredentials: Request PW validate');
                                      print('User = $_inputUser');
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                              child: SizedBox(
                                height: 30,
                                width: 150,
                                child: FlatButton(
                                  child: const Text('back',
                                      style: TextStyle(fontSize: 16)),
                                  color: Colors.grey,
                                  highlightColor: Colors.deepPurple,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    print(
                                        'userCredentials: back to sign in pressed');
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
