import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/bottom_navigation/presentation/bottom_navigation_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignupController {
  static String? validEmail(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    final signUpFormNotitfier = ref.read(signUpFormRiverpodProvider.notifier);
    var result = signUpFormNotitfier.correctEmail(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? passwordFieldValidator(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(signUpFormRiverpodProvider.notifier)
        .passwordFieldValidation(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? nameFieldValidator(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(signUpFormRiverpodProvider.notifier)
        .nameFieldValidation(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? bloodFieldValidator(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    final result = ref
        .read(signUpFormRiverpodProvider.notifier)
        .bloodFieldValidation(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static Future<void> signUp({
    required String name,
    required String email,
    String? bloodGroup,
    required String password,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final signUpFormNotitfier = ref.read(signUpFormRiverpodProvider.notifier);
    signUpFormNotitfier.setLoading(true);
    try {
      // Create user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get user ID
      String uid = userCredential.user!.uid;

      // Save user data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'bloodgroup': bloodGroup,
        'createdAt': Timestamp.now(),
      });

      // Read back the user data (optional)
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!doc.exists || doc.data() == null) {
        throw Exception("User data not found in Firestore.");
      }

      final userData = doc.data()!;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('User registered successfully!')));
      var record = (userCredential.user, userData);
      GoRouter.of(context).go(BottomNavigationPage.pageName, extra: record);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Unexpected error: $e')));
      }
    } finally {
      signUpFormNotitfier.setLoading(false);
    }
  }

  static void onPressedLogin({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String name,
    required String email,
    String? bloodGroup,
    required String password,
    required WidgetRef ref,
  }) {
    if (formKey.currentState?.validate() ?? false) {
      signUp(
        name: name,
        email: email,
        bloodGroup: bloodGroup,
        password: password,
        context: context,
        ref: ref,
      );
    }
  }
}
