import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'sign_in_form_state.dart'; // import the state class
import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/commonfunctions/extension_on_string.dart';

class SignInFormNotifier extends StateNotifier<SignInFormState> {
  SignInFormNotifier() : super(const SignInFormState());

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setGoogleLoading(bool value) {
    state = state.copyWith(isGoogleLoading: value);
  }

  void setPasswordVisibility(bool value) {
    state = state.copyWith(isPasswordVisible: value);
  }

  String? correctEmail(String? value) {
    if (value.isValidEmail()) {
      state = state.copyWith(
        textFieldEmailColorDark: AppColors.textDark,
        textFieldEmailColorLight: AppColors.textLight,
        email: 'Email',
      );
      return null;
    } else {
      state = state.copyWith(
        email: 'Invalid email',
        textFieldEmailColorDark: Colors.red,
        textFieldEmailColorLight: Colors.red,
      );
      return '';
    }
  }

  String? isTextFieldEmpty(String? value) {
    if (value != '') {
      state = state.copyWith(
        textFieldPasswordColorDark: AppColors.textDark,
        textFieldPasswordColorLight: AppColors.textLight,
        password: 'Password',
      );
      return null;
    } else {
      state = state.copyWith(
        password: 'Field is empty',
        textFieldPasswordColorDark: Colors.red,
        textFieldPasswordColorLight: Colors.red,
      );
      return '';
    }
  }
}
