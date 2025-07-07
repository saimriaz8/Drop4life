import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

class SignInFormState {
  final Color textFieldEmailColorDark;
  final Color textFieldPasswordColorDark;
  final Color textFieldEmailColorLight;
  final Color textFieldPasswordColorLight;
  final bool isLoading;
  final bool isGoogleLoading;
  final String email;
  final String password;
  final bool isPasswordVisible;

  const SignInFormState({
    this.textFieldEmailColorDark = AppColors.textDark,
    this.textFieldPasswordColorDark = AppColors.textDark,
    this.textFieldEmailColorLight = AppColors.textLight,
    this.textFieldPasswordColorLight = AppColors.textLight,
    this.isLoading = false,
    this.isGoogleLoading = false,
    this.email = 'Email',
    this.password = 'Password',
    this.isPasswordVisible = false,
  });

  SignInFormState copyWith({
    Color? textFieldEmailColorDark,
    Color? textFieldPasswordColorDark,
    Color? textFieldEmailColorLight,
    Color? textFieldPasswordColorLight,
    bool? isLoading,
    bool? isGoogleLoading,
    String? email,
    String? password,
    bool? isPasswordVisible,
  }) {
    return SignInFormState(
      textFieldEmailColorDark:
          textFieldEmailColorDark ?? this.textFieldEmailColorDark,
      textFieldPasswordColorDark:
          textFieldPasswordColorDark ?? this.textFieldPasswordColorDark,
      textFieldEmailColorLight:
          textFieldEmailColorLight ?? this.textFieldEmailColorLight,
      textFieldPasswordColorLight:
          textFieldPasswordColorLight ?? this.textFieldPasswordColorLight,
      isLoading: isLoading ?? this.isLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
