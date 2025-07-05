import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/auth/sign_up/logic/signup_controller.dart';
import 'package:drop4life/shared/widgets/circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignUpButton({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpFormRiverpodProvider);
    final width = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: width * 0.65,
      child: ElevatedButton(
        onPressed: () {
          final name = nameController.text.trim();
          final email = emailController.text.trim();
          final password = passwordController.text.trim();
          final bloodGroup = state.selectedBloodGroup;

          SignupController.onPressedLogin(
            context: context,
            formKey: formKey,
            name: name,
            email: email,
            password: password,
            bloodGroup: bloodGroup,
            ref: ref,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: state.isLoading
            ? const CircularProgressIndicatorWidget()
            : const Text(
                'Sign up',
                style: TextStyle(color: AppColors.textLight),
              ),
      ),
    );
  }
}
