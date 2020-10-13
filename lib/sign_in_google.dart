// import flutter packages (pub.dev for a list of available extensions
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Constructor
  SignInService();

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
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      return '$user';
    }
    return null;
  }

  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();
  }
}

final SignInService signInService = SignInService();
