import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/auth/sign_in/logic/signin_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInPasswordFormField extends ConsumerWidget {
  final Animation<double> animation;
  final TextEditingController controller;
  final AnimationController animationController;

  const SignInPasswordFormField({
    super.key,
    required this.animation,
    required this.controller,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final passwordLabel = ref.watch(
      signInFormRiverpodProvider.select((value) => value.password),
    );
    final passwordLightColor = ref.watch(
      signInFormRiverpodProvider.select(
        (value) => value.textFieldPasswordColorLight,
      ),
    );

    final passwordDarkColor = ref.watch(
      signInFormRiverpodProvider.select(
        (value) => value.textFieldPasswordColorDark,
      ),
    );

    final isPasswordVisible = ref.watch(
      signInFormRiverpodProvider.select((value) => value.isPasswordVisible),
    );

    return ShakingFormField(
      obscureText: !isPasswordVisible,
      keyBoardType: TextInputType.visiblePassword,
      textEditingController: controller,
      obscurePasswordButton: IconButton(
        onPressed:
            () => ref
                .read(signInFormRiverpodProvider.notifier)
                .setPasswordVisibility(!isPasswordVisible),
        icon: Icon(
          isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          color:
              Theme.of(context).brightness == Brightness.light
                  ? AppColors.textDark
                  : AppColors.textLight,
        ),
      ),
      validator:
          (fieldText) => SignInController.fieldNotNull(
            context,
            fieldText,
            animationController,
            ref,
          ),
      fieldName: passwordLabel,
      color:
          Theme.of(context).brightness == Brightness.light
              ? passwordDarkColor
              : passwordLightColor,
      anime: animation,
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
    );
  }
}
