import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestBloodFormPhoneFieldWidget extends ConsumerWidget {
  final Animation<double> animation;
  final AnimationController controller;
  final TextEditingController textController;
  final double width;
  final double height;

  const RequestBloodFormPhoneFieldWidget({
    super.key,
    required this.animation,
    required this.controller,
    required this.textController,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  phoneFieldName = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.phoneFieldName,));
    final  phoneFieldDarkColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldPhoneColorDark,));
    final  phoneFieldLightColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldPhoneColorLight,));
    return ShakingFormField(
      keyBoardType: TextInputType.phone,
      textEditingController: textController,
      validator: (fieldText) => RequestBloodFormController.validPhone(
        context,
        fieldText,
        controller,
        ref,
      ),
      fieldName: phoneFieldName,
      color: Theme.of(context).brightness == Brightness.light
          ? phoneFieldDarkColor
          : phoneFieldLightColor,
      anime: animation,
      height: height,
      width: width,
    );
  }
}
