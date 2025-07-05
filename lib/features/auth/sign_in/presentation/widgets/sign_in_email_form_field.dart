import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/auth/sign_in/logic/signin_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInEmailFormField extends ConsumerWidget {
  final Animation<double> animation;
  final TextEditingController controller;
  final AnimationController animationController;

  const SignInEmailFormField({
    super.key,
    required this.animation,
    required this.controller,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailLabel = ref.watch(
      signInFormRiverpodProvider.select((value) => value.email),
    );
    final emailDarkColor = ref.watch(
      signInFormRiverpodProvider.select(
        (value) => value.textFieldEmailColorDark,
      ),
    );
    final emailLightColor = ref.watch(
      signInFormRiverpodProvider.select(
        (value) => value.textFieldEmailColorLight,
      ),
    );

    return ShakingFormField(
      keyBoardType: TextInputType.emailAddress,
      textEditingController: controller,
      validator:
          (fieldText) => SignInController.validEmail(
            context,
            fieldText,
            animationController,
            ref
          ),
      fieldName: emailLabel,
      color:
          Theme.of(context).brightness == Brightness.light
              ? emailDarkColor
              : emailLightColor,
      anime: animation,
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
    );
  }
}
