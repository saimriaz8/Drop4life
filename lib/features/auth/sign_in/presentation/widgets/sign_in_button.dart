import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/auth/sign_in/logic/signin_controller.dart';
import 'package:drop4life/shared/widgets/circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const SignInButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(
      signInFormRiverpodProvider.select((value) => value.isLoading),
    );
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.65,
      child: ElevatedButton(
        onPressed:
            () => SignInController.onPressedLogin(
              context: context,
              formKey: formKey,
              emailController: emailController,
              passwordController: passwordController,
              ref: ref
            ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          overlayColor: Color.fromRGBO(255, 255, 255, 0.2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child:
            isLoading
                ? const CircularProgressIndicatorWidget()
                : const Text(
                  'Sign in',
                  style: TextStyle(color: AppColors.textLight),
                ),
      ),
    );
  }
}
