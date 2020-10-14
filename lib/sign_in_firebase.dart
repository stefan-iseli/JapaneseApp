// import flutter packages (pub.dev for a list of available extensions
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Constructor
  SignInService();

  // Stream: Listener to Auth changes

  Future<String> firebaseAuthChanges() async {
    FirebaseAuth.instance.authStateChanges().listen(
      (User user) {
        if (user == null) {
          print('User is currently signed out!');
          return null;
        } else {
          print('Firebase user is $user');
        }
      },
    );
    final User currentUser = _auth.currentUser;
    print('User is signed in! $currentUser');
    return '$currentUser';
  }

  // Sign in and sign out Google account
  // -----------------------------------
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      final User currentUser = _auth.currentUser;
      return '$currentUser';
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }

// Sign in and sign out with own ID/PW (email address and PW)
// UserId and Password input are
//
  Future<String> signInWithEmail(String _inUser, String _inPW) async {
    print('UserId / PW is $_inUser/$_inPW');
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _inUser, password: _inPW);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return null;
      }
    }
    final User currentUser = _auth.currentUser;
    return '$currentUser';
  }

  Future<void> signOutEmail() async {}
}

final SignInService signInService = SignInService();
