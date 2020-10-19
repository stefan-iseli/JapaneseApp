// import flutter packages (pub.dev for a list of available extensions
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Constructor
  GoogleSignInService();

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

  Future<bool> signOutGoogle() async {
    final GoogleSignInAccount googleSignOutAccount =
        await googleSignIn.signOut();
    if (googleSignOutAccount == null) {
      return true;
    }
    print('signOutGoogle: User ' +
        googleSignOutAccount.email +
        ' stilled signed in');
    return false;
  }
}

final GoogleSignInService googleSignInService = GoogleSignInService();
