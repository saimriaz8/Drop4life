import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/auth/sign_up/logic/signup_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpEmailFieldWidget extends ConsumerWidget {
  final Animation<double> animation;
  final AnimationController animationController;
  final TextEditingController controller;
  final double height;
  final double width;

  const SignUpEmailFieldWidget({
    required this.animation,
    required this.animationController,
    required this.controller,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailFieldName = ref.watch(
      signUpFormRiverpodProvider.select((value) => value.emailFieldName),
    );
    final isLight = Theme.of(context).brightness == Brightness.light;
    final emailFieldDarkColor = ref.watch(
      signUpFormRiverpodProvider.select(
        (value) => value.textFieldEmailColorDark,
      ),
    );
    final emailFieldLightColor = ref.watch(
      signUpFormRiverpodProvider.select(
        (value) => value.textFieldEmailColorLight,
      ),
    );

    return ShakingFormField(
      keyBoardType: TextInputType.emailAddress,
      textEditingController: controller,
      validator:
          (value) =>
              SignupController.validEmail(context, value, animationController, ref),
      fieldName: emailFieldName,
      color: isLight ? emailFieldDarkColor : emailFieldLightColor,
      anime: animation,
      height: height,
      width: width,
    );
  }
}
