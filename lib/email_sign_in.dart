// import flutter packages (pub.dev for a list of available extensions
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

//include own made flutter code files
import 'package:japaneseapp/global.dart' as global;
import 'package:japaneseapp/show_dialog.dart';

class EmailSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Constructor
  EmailSignInService();

// Sign in and sign out with own ID/PW (email address and PW)
//
  Future<String> signInWithEmail(String _inUser, String _inPW) async {
    final UserCredential authResult =
        await _auth.signInWithEmailAndPassword(email: _inUser, password: _inPW);
    final User user = authResult.user;

    if (user != null) {
      final User currentUser = _auth.currentUser;
      return '$currentUser';
    }
    return null;
  }

  Future<String> signOutEmail() async {
    FirebaseAuth.instance.currentUser;
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  Future<String> signUpWithEmail(BuildContext context, String _inUser,
      String _inPW, String _inDisplayName, String _inPhotoURL) async {
    String _code = 'xxxxxxx';

    final UserCredential authResult = await _auth
        .createUserWithEmailAndPassword(email: _inUser, password: _inPW);
    final User user = authResult.user;
    if (user != null) {
      final User currentUser = _auth.currentUser;
      await user.updateProfile(
          displayName: _inDisplayName, photoURL: _inPhotoURL);
      showMyDialog(context, 'Sign-up', 'Confirmation email has been sent',
          'please check and confirm');
      await user.sendEmailVerification();
      try {
        await _auth.checkActionCode(_code);
        await _auth.applyActionCode(_code);
        return '$currentUser';
      } on Exception catch (e) {
        global.myErrorMessage = e.toString();
        return null;
      }
    }
    return null;
  }
}

final EmailSignInService emailSignInService = EmailSignInService();
