import 'package:flutter/material.dart';
import 'package:drop4life/core/appcolors/app_colors.dart';

class RequestBloodFormState {
  final Color textFieldPhoneColorDark;
  final Color textFieldUnitsColorDark;
  final Color textFieldNameColorDark;
  final Color textFieldBloodColorDark;
  final Color textFieldCityColorDark;
  final Color textFieldAddressColorDark;

  final Color textFieldPhoneColorLight;
  final Color textFieldUnitsColorLight;
  final Color textFieldNameColorLight;
  final Color textFieldBloodColorLight;
  final Color textFieldCityColorLight;
  final Color textFieldAddressColorLight;

  final bool isLoading;
  final String? selectedBloodGroup;
  final String? selectedCity;

  final String nameFieldName;
  final String phoneFieldName;
  final String unitsNeededFieldName;
  final String bloodFieldName;
  final String cityFieldName;
  final String addressFieldName;

  const RequestBloodFormState({
    this.textFieldPhoneColorDark = AppColors.textDark,
    this.textFieldUnitsColorDark = AppColors.textDark,
    this.textFieldNameColorDark = AppColors.textDark,
    this.textFieldBloodColorDark = AppColors.textDark,
    this.textFieldCityColorDark = AppColors.textDark,
    this.textFieldAddressColorDark = AppColors.textDark,
    this.textFieldPhoneColorLight = AppColors.textLight,
    this.textFieldUnitsColorLight = AppColors.textLight,
    this.textFieldNameColorLight = AppColors.textLight,
    this.textFieldBloodColorLight = AppColors.textLight,
    this.textFieldCityColorLight = AppColors.textLight,
    this.textFieldAddressColorLight = AppColors.textLight,
    this.isLoading = false,
    this.selectedBloodGroup,
    this.selectedCity,
    this.nameFieldName = 'Full Name',
    this.phoneFieldName = 'Phone',
    this.unitsNeededFieldName = 'Units Needed',
    this.bloodFieldName = 'Blood Group',
    this.cityFieldName = 'Available Cities',
    this.addressFieldName = 'Address',
  });

  RequestBloodFormState copyWith({
    Color? textFieldPhoneColorDark,
    Color? textFieldUnitsColorDark,
    Color? textFieldNameColorDark,
    Color? textFieldBloodColorDark,
    Color? textFieldCityColorDark,
    Color? textFieldAddressColorDark,
    Color? textFieldPhoneColorLight,
    Color? textFieldUnitsColorLight,
    Color? textFieldNameColorLight,
    Color? textFieldBloodColorLight,
    Color? textFieldCityColorLight,
    Color? textFieldAddressColorLight,
    bool? isLoading,
    String? selectedBloodGroup,
    String? selectedCity,
    String? nameFieldName,
    String? phoneFieldName,
    String? unitsNeededFieldName,
    String? bloodFieldName,
    String? cityFieldName,
    String? addressFieldName,
  }) {
    return RequestBloodFormState(
      textFieldPhoneColorDark: textFieldPhoneColorDark ?? this.textFieldPhoneColorDark,
      textFieldUnitsColorDark: textFieldUnitsColorDark ?? this.textFieldUnitsColorDark,
      textFieldNameColorDark: textFieldNameColorDark ?? this.textFieldNameColorDark,
      textFieldBloodColorDark: textFieldBloodColorDark ?? this.textFieldBloodColorDark,
      textFieldCityColorDark: textFieldCityColorDark ?? this.textFieldCityColorDark,
      textFieldAddressColorDark: textFieldAddressColorDark ?? this.textFieldAddressColorDark,
      textFieldPhoneColorLight: textFieldPhoneColorLight ?? this.textFieldPhoneColorLight,
      textFieldUnitsColorLight: textFieldUnitsColorLight ?? this.textFieldUnitsColorLight,
      textFieldNameColorLight: textFieldNameColorLight ?? this.textFieldNameColorLight,
      textFieldBloodColorLight: textFieldBloodColorLight ?? this.textFieldBloodColorLight,
      textFieldCityColorLight: textFieldCityColorLight ?? this.textFieldCityColorLight,
      textFieldAddressColorLight: textFieldAddressColorLight ?? this.textFieldAddressColorLight,
      isLoading: isLoading ?? this.isLoading,
      selectedBloodGroup: selectedBloodGroup ?? this.selectedBloodGroup,
      selectedCity: selectedCity ?? this.selectedCity,
      nameFieldName: nameFieldName ?? this.nameFieldName,
      phoneFieldName: phoneFieldName ?? this.phoneFieldName,
      unitsNeededFieldName: unitsNeededFieldName ?? this.unitsNeededFieldName,
      bloodFieldName: bloodFieldName ?? this.bloodFieldName,
      cityFieldName: cityFieldName ?? this.cityFieldName,
      addressFieldName: addressFieldName ?? this.addressFieldName,
    );
  }
}
