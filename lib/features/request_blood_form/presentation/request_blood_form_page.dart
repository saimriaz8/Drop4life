import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/presentation/widgets/request_blood_form_address_field_widget.dart';
import 'package:drop4life/features/request_blood_form/presentation/widgets/request_blood_form_blood_dropdown_widget.dart';
import 'package:drop4life/features/request_blood_form/presentation/widgets/request_blood_form_city_dropdown_widget.dart';
import 'package:drop4life/features/request_blood_form/presentation/widgets/request_blood_form_full_name_field_widget.dart';
import 'package:drop4life/features/request_blood_form/presentation/widgets/request_blood_form_phone_field.dart';
import 'package:drop4life/features/request_blood_form/presentation/widgets/request_blood_form_submit_button_widget.dart';
import 'package:drop4life/features/request_blood_form/presentation/widgets/request_blood_form_units_needed_field.dart';
import 'package:drop4life/shared/widgets/recipient_or_donor_page_clipper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class RequestBloodFormPage extends StatefulWidget {
  final (User?, Map<String, dynamic>) record;
  const RequestBloodFormPage({super.key, required this.record});
  @override
  State<RequestBloodFormPage> createState() => _RequestBloodFormPageState();
  static const String pageName = '/requestbloodform';
}

class _RequestBloodFormPageState extends State<RequestBloodFormPage>
    with TickerProviderStateMixin {
  late AnimationController fullNameAnimationController;
  late AnimationController phoneAnimationController;
  late AnimationController unitsNeededAnimationController;
  late AnimationController bloodGroupAnimationController;
  late AnimationController cityAnimationController;
  late AnimationController addressAnimationController;

  late Animation<double> fullNameAnimation;
  late Animation<double> phoneAnimation;
  late Animation<double> unitsNeededAnimation;
  late Animation<double> bloodGroupAnimation;
  late Animation<double> cityAnimation;
  late Animation<double> addressAnimation;

  final GlobalKey<FormState> _requestBloodFormKey = GlobalKey();

  late TextEditingController fullNameTextFieldController;
  late TextEditingController phoneTextFieldController;
  late TextEditingController unitsNeededTextFieldController;
  late TextEditingController addressTextFieldController;

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
    fullNameAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    phoneAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    unitsNeededAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    bloodGroupAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    cityAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    addressAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    fullNameAnimation = shakeTween.animate(fullNameAnimationController);
    phoneAnimation = shakeTween.animate(phoneAnimationController);
    unitsNeededAnimation = shakeTween.animate(unitsNeededAnimationController);
    bloodGroupAnimation = shakeTween.animate(bloodGroupAnimationController);
    cityAnimation = shakeTween.animate(cityAnimationController);
    addressAnimation = shakeTween.animate(addressAnimationController);

    fullNameTextFieldController = TextEditingController();
    phoneTextFieldController = TextEditingController();
    unitsNeededTextFieldController = TextEditingController();
    addressTextFieldController = TextEditingController();

    var data = widget.record.$2;
    fullNameTextFieldController.text = data['name'] ?? 'John';
  }

  @override
  void dispose() {
    super.dispose();
    fullNameAnimationController.dispose();
    phoneAnimationController.dispose();
    unitsNeededAnimationController.dispose();
    bloodGroupAnimationController.dispose();
    cityAnimationController.dispose();
    addressAnimationController.dispose();

    fullNameTextFieldController.dispose();
    phoneTextFieldController.dispose();
    unitsNeededTextFieldController.dispose();
    addressTextFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
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
                top: 10,
                left: 10,
                right: 10,
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

                      // FittedBox(
                      //   child: Text(
                      //     'When you need a hero, just ask.',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 25,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),

              /// Expanded scrollable area
              Positioned(
                top: 100,
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
                          key: _requestBloodFormKey,
                          child: Column(
                            children: [
                              Text(
                                'Request Blood',
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
                              RequestBloodFormFullNameFieldWidget(
                                animation: fullNameAnimation,
                                controller: fullNameAnimationController,
                                textController: fullNameTextFieldController,
                                width: width,
                                height: height,
                              ),
                              const SizedBox(height: 20),
                              RequestBloodFormPhoneFieldWidget(
                                animation: phoneAnimation,
                                controller: phoneAnimationController,
                                textController: phoneTextFieldController,
                                width: width,
                                height: height,
                              ),
                              const SizedBox(height: 20),
                              RequestBloodFormUnitsNeededFieldWidget(
                                controller: unitsNeededTextFieldController,
                                animation: unitsNeededAnimation,
                                animationController:
                                    unitsNeededAnimationController,
                                height: height,
                                width: width,
                              ),
                              const SizedBox(height: 20),
                              RequestBloodFormAddressFieldWidget(
                                controller: addressTextFieldController,
                                animation: addressAnimation,
                                animationController: addressAnimationController,
                                height: height,
                                width: width,
                              ),
                              const SizedBox(height: 20),
                              RequestBloodFormBloodGroupDropdownFieldWidget(
                                animation: bloodGroupAnimation,
                                height: height,
                                width: width,
                                animationController:
                                    bloodGroupAnimationController,
                              ),
                              const SizedBox(height: 20),
                              RequestBloodFormCityDropdownFieldWidget(
                                animation: cityAnimation,
                                height: height,
                                width: width,
                                animationController: cityAnimationController,
                              ),
                              const SizedBox(height: 20),
                              SubmitRequestButton(
                                formKey: _requestBloodFormKey,
                                phoneController: phoneTextFieldController,
                                nameController: fullNameTextFieldController,
                                unitsController: unitsNeededTextFieldController,
                                addressController: addressTextFieldController,
                                record: widget.record,
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
