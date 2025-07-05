import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/auth/sign_up/logic/signup_controller.dart';
import 'package:drop4life/shared/widgets/dropdown_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpBloodGroupFieldWidget extends ConsumerWidget {
  final Animation<double> animation;
  final AnimationController animationController;
  final double height;
  final double width;

  const SignUpBloodGroupFieldWidget({
    required this.animation,
    required this.animationController,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodGroupFieldName = ref.watch(signUpFormRiverpodProvider.select((value) => value.bloodFieldName,));
    final notifier = ref.read(signUpFormRiverpodProvider.notifier);
    final isLight = Theme.of(context).brightness == Brightness.light;
    final bloodGroupDarkColor = ref.watch(signUpFormRiverpodProvider.select((value) => value.textFieldBloodColorDark,));
    final bloodGroupLightColor = ref.watch(signUpFormRiverpodProvider.select((value) => value.textFieldBloodColorLight,));
    final slectedBloodGroup = ref.watch(signUpFormRiverpodProvider.select((value) => value.selectedBloodGroup,));
    return DropdownFieldWidget(
      fieldName: bloodGroupFieldName,
      animation: animation,
      height: height,
      width: width,
      color:
          isLight
              ? bloodGroupDarkColor
              : bloodGroupLightColor,
      items: const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
      onChanged: notifier.selectGroup,
      validator:
          (value) => SignupController.bloodFieldValidator(
            context,
            value,
            animationController,
            ref,
          ),
      value: slectedBloodGroup == '' ? null : slectedBloodGroup,
    );
  }
}
