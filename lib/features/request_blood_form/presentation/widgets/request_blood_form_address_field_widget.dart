import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestBloodFormAddressFieldWidget extends ConsumerWidget {
  const RequestBloodFormAddressFieldWidget({
    super.key,
    required this.controller,
    required this.animation,
    required this.animationController,
    required this.height,
    required this.width,
  });

  final TextEditingController controller;
  final Animation<double> animation;
  final AnimationController animationController;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressFieldName = ref.watch(
      requestBloodFormRiverpoodProvider.select(
        (value) => value.addressFieldName,
      ),
    );
    final addressFieldDarkColor = ref.watch(
      requestBloodFormRiverpoodProvider.select(
        (value) => value.textFieldAddressColorDark,
      ),
    );
    final addressFieldLightColor = ref.watch(
      requestBloodFormRiverpoodProvider.select(
        (value) => value.textFieldAddressColorLight,
      ),
    );

    return ShakingFormField(
      keyBoardType: TextInputType.streetAddress,
      textEditingController: controller,
      validator:
          (value) => RequestBloodFormController.validAddress(
            context,
            value,
            animationController,
            ref,
          ),
      fieldName: addressFieldName,
      color:
          Theme.of(context).brightness == Brightness.light
              ? addressFieldDarkColor
              : addressFieldLightColor,
      anime: animation,
      height: height,
      width: width,
    );
  }
}
