import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'request_blood_form_state.dart';
import 'package:drop4life/core/commonfunctions/extension_on_string.dart';

class RequestBloodFormNotifier extends StateNotifier<RequestBloodFormState> {
  RequestBloodFormNotifier() : super(const RequestBloodFormState());

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  String? validPhone(String? value) {
    if (value.isValidPhoneNumber()) {
      state = state.copyWith(
        textFieldPhoneColorDark: AppColors.textDark,
        textFieldPhoneColorLight: AppColors.textLight,
        phoneFieldName: 'Phone',
      );
      return null;
    } else {
      state = state.copyWith(
        phoneFieldName: 'Invalid Phone Number',
        textFieldPhoneColorDark: Colors.red,
        textFieldPhoneColorLight: Colors.red,
      );
      return '';
    }
  }

  String? unitsNeededFieldValidationProvider(String? value) {
    if (value != '') {
      state = state.copyWith(
        textFieldUnitsColorDark: AppColors.textDark,
        textFieldUnitsColorLight: AppColors.textLight,
        unitsNeededFieldName: 'Units Needed',
      );
      return null;
    } else {
      state = state.copyWith(
        textFieldUnitsColorDark: Colors.red,
        textFieldUnitsColorLight: Colors.red,
        unitsNeededFieldName: 'Field Is Empty',
      );
      return '';
    }
  }

  String? fullNameFieldValidationProvider(String? value) {
    if (value != '') {
      state = state.copyWith(
        textFieldNameColorDark: Colors.black,
        textFieldNameColorLight: AppColors.textLight,
        nameFieldName: 'Full Name',
      );
      return null;
    } else {
      state = state.copyWith(
        textFieldNameColorDark: Colors.red,
        textFieldNameColorLight: Colors.red,
        nameFieldName: 'Field Is Empty',
      );
      return '';
    }
  }

  String? addressFieldValidationProvider(String? value) {
    if (value != '') {
      state = state.copyWith(
        textFieldAddressColorDark: Colors.black,
        textFieldAddressColorLight: AppColors.textLight,
        addressFieldName: 'Address',
      );
      return null;
    } else {
      state = state.copyWith(
        textFieldAddressColorDark: Colors.red,
        textFieldAddressColorLight: Colors.red,
        addressFieldName: 'Field is empty',
      );
      return '';
    }
  }

  String? bloodFieldValidationProvider(String? value) {
    if (value != null && value.isNotEmpty) {
      state = state.copyWith(
        textFieldBloodColorDark: AppColors.textDark,
        textFieldBloodColorLight: AppColors.textLight,
        bloodFieldName: 'Blood group',
      );
      return null;
    } else {
      state = state.copyWith(
        textFieldBloodColorDark: Colors.red,
        textFieldBloodColorLight: Colors.red,
        bloodFieldName: 'Please Select Blood Group',
      );
      return '';
    }
  }

  String? cityFieldValidationProvider(String? value) {
    if (value != null && value.isNotEmpty) {
      state = state.copyWith(
        textFieldCityColorDark: AppColors.textDark,
        textFieldCityColorLight: AppColors.textLight,
        cityFieldName: 'Available Cities',
      );
      return null;
    } else {
      state = state.copyWith(
        textFieldCityColorDark: Colors.red,
        textFieldCityColorLight: Colors.red,
        cityFieldName: 'Please Select City',
      );
      return '';
    }
  }

  void selectGroup(String? val) {
    state = state.copyWith(selectedBloodGroup: val);
  }

  void selectCity(String? val) {
    state = state.copyWith(selectedCity: val);
  }
}

final requestBloodFormProvider = StateNotifierProvider<RequestBloodFormNotifier, RequestBloodFormState>(
  (ref) => RequestBloodFormNotifier(),
);
