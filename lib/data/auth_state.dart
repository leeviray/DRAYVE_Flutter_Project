import 'package:firebase_auth/firebase_auth.dart';

/// Whether Firebase Authentication currently has a signed-in user.
bool get globalIsLoggedIn => FirebaseAuth.instance.currentUser != null;
