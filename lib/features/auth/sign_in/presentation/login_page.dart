import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/features/auth/sign_in/logic/signin_controller.dart';
import 'package:drop4life/features/auth/sign_in/presentation/widgets/google_sign_in.dart';
import 'package:drop4life/features/auth/sign_in/presentation/widgets/sign_in_button.dart';
import 'package:drop4life/features/auth/sign_in/presentation/widgets/sign_in_email_form_field.dart';
import 'package:drop4life/features/auth/sign_in/presentation/widgets/sign_in_password_field.dart';
import 'package:drop4life/shared/widgets/recipient_or_donor_page_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
  static const String pageName = '/login';
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController animationControllerEmail;
  late Animation<double> animationEmail;
  late AnimationController animationControllerPassword;
  late Animation<double> animationPassword;
  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController emailTextFieldController;
  late TextEditingController passwordTextFieldController;

  final shakeTween = TweenSequence<double>([
    TweenSequenceItem(tween: Tween(begin: 0, end: 10), weight: 1),
    TweenSequenceItem(tween: Tween(begin: 10, end: -10), weight: 2),
    TweenSequenceItem(tween: Tween(begin: -10, end: 8), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
    TweenSequenceItem(tween: Tween(begin: -8, end: 5), weight: 2),
    TweenSequenceItem(tween: Tween(begin: 5, end: 0), weight: 2),
  ]);

  @override
  void initState() {
    super.initState();
    animationControllerEmail = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationControllerPassword = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationEmail = shakeTween.animate(animationControllerEmail);
    animationPassword = shakeTween.animate(animationControllerPassword);

    emailTextFieldController = TextEditingController();
    passwordTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    animationControllerEmail.dispose();
    animationControllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).brightness == Brightness.dark ? AppColors.textLight : AppColors.textDark,
      ),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false, // Prevent UI shift on keyboard
          body: Stack(
            children: [
              /// 🔴 Background Layer
              ClipPath(
                clipper: RecipientOrDonorPageClipper(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: AppColors.primaryColor,
                ),
              ),
        
              Positioned(
                top: 50,
                left: 30,
                right: 30,
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/blood_donation_logo.png',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      FittedBox(
                        child: Text(
                          'Hello! Welcome Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        
              /// Expanded scrollable area
              Positioned(
                top: 250,
                left: 30,
                right: 30,
                child: SingleChildScrollView(
                  reverse: false,
        
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        width: width * 0.9,
        
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SignInEmailFormField(animation: animationEmail, controller: emailTextFieldController, animationController: animationControllerEmail),
                              const SizedBox(height: 20),
                              SignInPasswordFormField(animation: animationPassword, controller: passwordTextFieldController, animationController: animationControllerPassword),
                              const SizedBox(height: 20),
                              SignInButton(formKey: formKey, emailController: emailTextFieldController, passwordController: passwordTextFieldController),
                              const SizedBox(height: 20),
                              GoogleSignInButton()
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () => SignInController.onPressedCreateAccount(context),
                  child: Container(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Sign up or create account',
                      style: TextStyle(
                        color:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
