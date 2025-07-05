import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/auth/sign_up/logic/signup_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpNameFieldWidget extends ConsumerWidget {
  final Animation<double> animation;
  final AnimationController animationController;
  final TextEditingController controller;
  final double height;
  final double width;

  const SignUpNameFieldWidget({
    required this.animation,
    required this.animationController,
    required this.controller,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final label = ref.watch(
      signUpFormRiverpodProvider.select((value) => value.nameFieldName),
    );

    final nameDarkColor = ref.watch(
      signUpFormRiverpodProvider.select(
        (value) => value.textFieldNameColorDark,
      ),
    );
    final nameLightColor = ref.watch(
      signUpFormRiverpodProvider.select(
        (value) => value.textFieldNameColorLight,
      ),
    );
    final isLight = Theme.of(context).brightness == Brightness.light;

    return ShakingFormField(
      keyBoardType: TextInputType.name,
      textEditingController: controller,
      validator:
          (value) => SignupController.nameFieldValidator(
            context,
            value,
            animationController,
            ref,
          ),
      fieldName: label,
      color: isLight ? nameDarkColor : nameLightColor,
      anime: animation,
      height: height,
      width: width,
    );
  }
}
