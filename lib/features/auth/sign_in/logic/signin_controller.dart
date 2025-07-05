import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/auth/sign_up/presentation/signup_page.dart';
import 'package:drop4life/features/bottom_navigation/presentation/bottom_navigation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
// adjust path if needed

class SignInController {
  static String? validEmail(
    BuildContext context,
    String? value,
    AnimationController animationControllerEmail,
    WidgetRef ref,
  ) {
    final formNotifier = ref.read(signInFormRiverpodProvider.notifier);
    var result = formNotifier.correctEmail(value);
    if (result != null) {
      animationControllerEmail.forward(from: 0);
    }
    return result;
  }

  static String? fieldNotNull(
    BuildContext context,
    String? value,
    AnimationController animationControllerPassword,
    WidgetRef ref,
  ) {
    var result = ref
        .read(signInFormRiverpodProvider.notifier)
        .isTextFieldEmpty(value);
    if (result != null) {
      animationControllerPassword.forward(from: 0);
    }
    return result;
  }

  static void onPressedLogin({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required WidgetRef ref,
  }) {
    if (formKey.currentState?.validate() ?? false) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      loginUser(email, password, context, ref);
    }
  }

  static Future<void> getDataFromUserCredential({
    required UserCredential credential,
    required BuildContext context,
  }) async {
    try {
      final uid = credential.user?.uid;
      final user = credential.user;
     
      if (uid == null || user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: User does not exist")),
        );
        return;
      }

      final docRef = FirebaseFirestore.instance.collection('users').doc(uid);
      final doc = await docRef.get();

      // If user data does not exist, create it
      if (!doc.exists) {
        await docRef.set({
          'name': user.displayName ?? '',
          'email': user.email ?? '',
          'image': user.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Map<String, dynamic> userData = (await docRef.get()).data()!;

      // Success: Navigate or notify
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login successfully')));
      var record = (user, userData);
      GoRouter.of(context).go(BottomNavigationPage.pageName, extra: record);
    } on FirebaseAuthException catch (e) {
      // Firebase login-specific errors
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Wrong password provided.')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unexpected error: $e')));
    }
  }

  static void loginUser(
    String email,
    String password,
    BuildContext context,
    WidgetRef ref,
  ) async {
    final formNotifier = ref.read(signInFormRiverpodProvider.notifier);
    formNotifier.setLoading(true);
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await getDataFromUserCredential(credential: credential, context: context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Wrong password provided.')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Unexpected error: $e')));
    } finally {
      formNotifier.setLoading(false);
    }
  }

  static void onPressedCreateAccount(BuildContext context) {
    GoRouter.of(context).push(SignupPage.pageName);
  }

  static Future<void> signInWithGoogle(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final formNotifier = ref.read(signInFormRiverpodProvider.notifier);
    formNotifier.setGoogleLoading(true);
    try {
      // Sign out first to force the account picker dialog
      await GoogleSignIn().signOut();

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return; // User canceled

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      await getDataFromUserCredential(
        credential: userCredential,
        context: context,
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Google Sign-In Error: $e')));
    } finally {
      formNotifier.setGoogleLoading(false);
    }
  }
}
