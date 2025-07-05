import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/commonfunctions/extension_on_string.dart';
import 'sign_up_form_state.dart';

class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormNotifier() : super(const SignUpFormState());

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void selectGroup(String? value) {
    state = state.copyWith(selectedBloodGroup: value);
  }

  void setPasswordVisibility(bool value) {
    state = state.copyWith(isPasswordVisible: value);
  }

  String? correctEmail(String? value) {
    if (value.isValidEmail()) {
      state = state.copyWith(
        emailFieldName: 'Email',
        textFieldEmailColorDark: AppColors.textDark,
        textFieldEmailColorLight: AppColors.textLight,
      );
      return null;
    } else {
      state = state.copyWith(
        emailFieldName: 'Invalid email',
        textFieldEmailColorDark: Colors.red,
        textFieldEmailColorLight: Colors.red,
      );
      return '';
    }
  }

  String? passwordFieldValidation(String? value) {
    if (value != null && value.isNotEmpty) {
      state = state.copyWith(
        passwordFieldName: 'Password',
        textFieldPasswordColorDark: AppColors.textDark,
        textFieldPasswordColorLight: AppColors.textLight,
      );
      return null;
    } else {
      state = state.copyWith(
        passwordFieldName: 'Field is empty',
        textFieldPasswordColorDark: Colors.red,
        textFieldPasswordColorLight: Colors.red,
      );
      return '';
    }
  }

  String? nameFieldValidation(String? value) {
    if (value != null && value.isNotEmpty) {
      state = state.copyWith(
        nameFieldName: 'Name',
        textFieldNameColorDark: AppColors.textDark,
        textFieldNameColorLight: AppColors.textLight,
      );
      return null;
    } else {
      state = state.copyWith(
        nameFieldName: 'Field is empty',
        textFieldNameColorDark: Colors.red,
        textFieldNameColorLight: Colors.red,
      );
      return '';
    }
  }

  String? bloodFieldValidation(String? value) {
    if (value != null && value.isNotEmpty) {
      state = state.copyWith(
        bloodFieldName: 'Blood Group',
        textFieldBloodColorDark: AppColors.textDark,
        textFieldBloodColorLight: AppColors.textLight,
      );
      return null;
    } else {
      state = state.copyWith(
        bloodFieldName: 'Please select blood group',
        textFieldBloodColorDark: Colors.red,
        textFieldBloodColorLight: Colors.red,
      );
      return '';
    }
  }
}
