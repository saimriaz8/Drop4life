import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestBloodFormUnitsNeededFieldWidget extends ConsumerWidget {
  const RequestBloodFormUnitsNeededFieldWidget({
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
    final unitsNeededFieldName = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.unitsNeededFieldName,));
    final unitsNeededFieldDarkColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldUnitsColorDark,));
    final unitsNeededFieldLightColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldUnitsColorLight,));
    // final notifier = ref.read(requestBloodFormRiverpoodProvider.notifier);
    return ShakingFormField(
      keyBoardType: TextInputType.number,
      textEditingController: controller,
      validator: (value) => RequestBloodFormController.validUnitsNeeded(context ,value, animationController, ref),
      fieldName: unitsNeededFieldName,
      color: Theme.of(context).brightness == Brightness.light
          ? unitsNeededFieldDarkColor
          : unitsNeededFieldLightColor,
      anime: animation,
      height: height,
      width: width,
    );
  }
}
