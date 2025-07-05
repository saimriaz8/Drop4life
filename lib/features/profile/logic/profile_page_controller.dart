import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePageController {
  static Future<void> signOutFromGoogle(BuildContext context) async {
    try {
      // Sign out from Google
      await GoogleSignIn().signOut();

      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();
      GoRouter.of(context).go(MyHomePage.pageName);
      print("User signed out from Google and Firebase.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }
}
