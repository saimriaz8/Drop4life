import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

class SignUpFormState {
  final Color textFieldEmailColorDark;
  final Color textFieldPasswordColorDark;
  final Color textFieldNameColorDark;
  final Color textFieldBloodColorDark;

  final Color textFieldEmailColorLight;
  final Color textFieldPasswordColorLight;
  final Color textFieldNameColorLight;
  final Color textFieldBloodColorLight;

  final bool isLoading;
  final bool isPasswordVisible;
  final String? selectedBloodGroup;

  final String nameFieldName;
  final String emailFieldName;
  final String passwordFieldName;
  final String bloodFieldName;

  const SignUpFormState({
    this.textFieldEmailColorDark = AppColors.textDark,
    this.textFieldPasswordColorDark = AppColors.textDark,
    this.textFieldNameColorDark = AppColors.textDark,
    this.textFieldBloodColorDark = AppColors.textDark,
    this.textFieldEmailColorLight = AppColors.textLight,
    this.textFieldPasswordColorLight = AppColors.textLight,
    this.textFieldNameColorLight = AppColors.textLight,
    this.textFieldBloodColorLight = AppColors.textLight,
    this.isLoading = false,
    this.selectedBloodGroup,
    this.nameFieldName = 'Name',
    this.emailFieldName = 'Email',
    this.passwordFieldName = 'Password',
    this.bloodFieldName = 'Blood Group',
    this.isPasswordVisible = false
  });

  SignUpFormState copyWith({
    Color? textFieldEmailColorDark,
    Color? textFieldPasswordColorDark,
    Color? textFieldNameColorDark,
    Color? textFieldBloodColorDark,
    Color? textFieldEmailColorLight,
    Color? textFieldPasswordColorLight,
    Color? textFieldNameColorLight,
    Color? textFieldBloodColorLight,
    bool? isLoading,
    String? selectedBloodGroup,
    String? nameFieldName,
    String? emailFieldName,
    String? passwordFieldName,
    String? bloodFieldName,
    bool? isPasswordVisible,
  }) {
    return SignUpFormState(
      textFieldEmailColorDark:
          textFieldEmailColorDark ?? this.textFieldEmailColorDark,
      textFieldPasswordColorDark:
          textFieldPasswordColorDark ?? this.textFieldPasswordColorDark,
      textFieldNameColorDark:
          textFieldNameColorDark ?? this.textFieldNameColorDark,
      textFieldBloodColorDark:
          textFieldBloodColorDark ?? this.textFieldBloodColorDark,
      textFieldEmailColorLight:
          textFieldEmailColorLight ?? this.textFieldEmailColorLight,
      textFieldPasswordColorLight:
          textFieldPasswordColorLight ?? this.textFieldPasswordColorLight,
      textFieldNameColorLight:
          textFieldNameColorLight ?? this.textFieldNameColorLight,
      textFieldBloodColorLight:
          textFieldBloodColorLight ?? this.textFieldBloodColorLight,
      isLoading: isLoading ?? this.isLoading,
      selectedBloodGroup: selectedBloodGroup ?? this.selectedBloodGroup,
      nameFieldName: nameFieldName ?? this.nameFieldName,
      emailFieldName: emailFieldName ?? this.emailFieldName,
      passwordFieldName: passwordFieldName ?? this.passwordFieldName,
      bloodFieldName: bloodFieldName ?? this.bloodFieldName,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
