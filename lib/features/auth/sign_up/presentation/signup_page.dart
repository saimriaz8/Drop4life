import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/features/auth/sign_up/presentation/widgets/sign_up_blood_group_dropdown_widget.dart';
import 'package:drop4life/features/auth/sign_up/presentation/widgets/sign_up_button_widget.dart';
import 'package:drop4life/features/auth/sign_up/presentation/widgets/sign_up_email_field_widget.dart';
import 'package:drop4life/features/auth/sign_up/presentation/widgets/sign_up_name_field.dart';
import 'package:drop4life/features/auth/sign_up/presentation/widgets/sign_up_password_field_widget.dart';
import 'package:drop4life/shared/widgets/recipient_or_donor_page_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
  static const String pageName = '/signup';
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  late AnimationController animationControllerEmail;
  late AnimationController animationControllerName;
  late AnimationController animationControllerPassword;
  late AnimationController animationControllerBloodGroup;

  late Animation<double> animationEmail;
  late Animation<double> animationName;
  late Animation<double> animationPassword;
  late Animation<double> animationBloodGroup;

  GlobalKey<FormState> formKey = GlobalKey();

  late TextEditingController nameTextFieldController;
  late TextEditingController emailTextFieldController;
  late TextEditingController passwordTextFieldController;
  late TextEditingController bloodGroupTextFieldController;

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

    animationControllerName = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    animationControllerBloodGroup = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    animationEmail = shakeTween.animate(animationControllerEmail);
    animationPassword = shakeTween.animate(animationControllerPassword);
    animationName = shakeTween.animate(animationControllerName);
    animationBloodGroup = shakeTween.animate(animationControllerBloodGroup);

    nameTextFieldController = TextEditingController();
    passwordTextFieldController = TextEditingController();
    emailTextFieldController = TextEditingController();
    bloodGroupTextFieldController = TextEditingController();
  }

  @override
  void dispose() {
    animationControllerEmail.dispose();
    animationControllerName.dispose();
    animationControllerPassword.dispose();
    animationControllerBloodGroup.dispose();

    nameTextFieldController.dispose();
    emailTextFieldController.dispose();
    passwordTextFieldController.dispose();
    bloodGroupTextFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.textLight
                : AppColors.textDark,
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
                top: 30,
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
                          'Join and save lives',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
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
                top: 200,
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
                                'Sign up',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? AppColors.textLight
                                          : AppColors.textDark,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SignUpNameFieldWidget(
                                animation: animationName,
                                animationController: animationControllerName,
                                controller: nameTextFieldController,
                                height: height,
                                width: width,
                              ),
                              const SizedBox(height: 20),
                              SignUpEmailFieldWidget(
                                animation: animationEmail,
                                animationController: animationControllerEmail,
                                controller: emailTextFieldController,
                                height: height,
                                width: width,
                              ),
                              const SizedBox(height: 20),
                              SignUpPasswordFieldWidget(
                                animation: animationPassword,
                                animationController:
                                    animationControllerPassword,
                                controller: passwordTextFieldController,
                                height: height,
                                width: width,
                              ),
                              const SizedBox(height: 20),
                              SignUpBloodGroupFieldWidget(
                                animation: animationBloodGroup,
                                animationController:
                                    animationControllerBloodGroup,
                                height: height,
                                width: width,
                              ),
                              const SizedBox(height: 20),
                              SignUpButton(
                                formKey: formKey,
                                nameController: nameTextFieldController,
                                emailController: emailTextFieldController,
                                passwordController: passwordTextFieldController,
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
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
