library my_globals;

import 'package:firebase_auth/firebase_auth.dart';

// global variables - in particular for user session
User myUser;
String myLoginMethod;

// general error messages
String myErrorMessage;

// filter on Favorite
bool myFiltered = false;
bool myVisibility = false;
