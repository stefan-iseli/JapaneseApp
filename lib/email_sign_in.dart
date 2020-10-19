// import flutter packages (pub.dev for a list of available extensions
import 'package:firebase_auth/firebase_auth.dart';

//include own made flutter code files
//import 'package:japaneseapp/global.dart' as global;

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
}

final EmailSignInService emailSignInService = EmailSignInService();

class EmailSignIn {}
