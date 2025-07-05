import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/auth/sign_up/logic/signup_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPasswordFieldWidget extends ConsumerWidget {
  final Animation<double> animation;
  final AnimationController animationController;
  final TextEditingController controller;
  final double height;
  final double width;

  const SignUpPasswordFieldWidget({
    required this.animation,
    required this.animationController,
    required this.controller,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordFieldName = ref.watch(
      signUpFormRiverpodProvider.select((value) => value.passwordFieldName),
    );
    final isLight = Theme.of(context).brightness == Brightness.light;
    final passwordFieldDarkColor = ref.watch(
      signUpFormRiverpodProvider.select(
        (value) => value.textFieldPasswordColorDark,
      ),
    );
    final passwordFieldLightColor = ref.watch(
      signUpFormRiverpodProvider.select(
        (value) => value.textFieldPasswordColorLight,
      ),
    );

    final isPasswordVisible = ref.watch(
      signUpFormRiverpodProvider.select((value) => value.isPasswordVisible),
    );

    return ShakingFormField(
      obscureText: !isPasswordVisible,
      keyBoardType: TextInputType.visiblePassword,
      textEditingController: controller,
      obscurePasswordButton: IconButton(
        onPressed: () => ref.read(signUpFormRiverpodProvider.notifier).setPasswordVisibility(!isPasswordVisible),
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color:
              Theme.of(context).brightness == Brightness.light
                  ? AppColors.textDark
                  : AppColors.textLight,
        ),
      ),
      validator:
          (value) => SignupController.passwordFieldValidator(
            context,
            value,
            animationController,
            ref,
          ),
      fieldName: passwordFieldName,
      color: isLight ? passwordFieldDarkColor : passwordFieldLightColor,
      anime: animation,
      height: height,
      width: width,
    );
  }
}
