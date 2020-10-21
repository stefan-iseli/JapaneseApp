// importing google platform packages
import 'package:flutter/material.dart';

//Alert Dialog with just a "back" option
void showMyDialog(
    BuildContext context, String title, String text1, String text2) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text1),
              Text(text2),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
              child: Text('continue'),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      );
    },
  );
}
