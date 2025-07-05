import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/auth/sign_in/logic/signin_controller.dart';
import 'package:drop4life/shared/widgets/circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleSignInButton extends ConsumerWidget {
  const GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isGoogleLoading = ref.watch(
      signInFormRiverpodProvider.select((value) => value.isGoogleLoading),
    );

    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.65,
      child: ElevatedButton(
        onPressed: () => SignInController.signInWithGoogle(context, ref),
        style: ElevatedButton.styleFrom(
          overlayColor: Colors.red.withAlpha(51),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: Colors.grey.shade300),
          ),
        ),
        child:
            isGoogleLoading
                ? const CircularProgressIndicatorWidget()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign in with google',
                      style: TextStyle(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppColors.textLight
                                : AppColors.textDark,
                      ),
                    ),
                    const SizedBox(width: 5),
                    FaIcon(
                      FontAwesomeIcons.google,
                      color:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppColors.textLight
                              : AppColors.textDark,
                    ),
                  ],
                ),
      ),
    );
  }
}
