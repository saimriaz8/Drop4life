import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_controller.dart';
import 'package:drop4life/shared/widgets/shaking_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestBloodFormFullNameFieldWidget extends ConsumerWidget {
  final Animation<double> animation;
  final AnimationController controller;
  final TextEditingController textController;
  final double width;
  final double height;

  const RequestBloodFormFullNameFieldWidget({
    super.key,
    required this.animation,
    required this.controller,
    required this.textController,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final namefieldName = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.nameFieldName,));
    final namefieldDarkColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldNameColorDark,));
    final namefieldLightColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldNameColorLight,));
    return ShakingFormField(
      isReadOnly: false,
      keyBoardType: TextInputType.name,
      textEditingController: textController,
      validator: (fieldText) => RequestBloodFormController.validName(
        context,
        fieldText,
        controller,
        ref,
      ),
      fieldName: namefieldName,
      color: Theme.of(context).brightness == Brightness.light
          ? namefieldDarkColor
          : namefieldLightColor,
      anime: animation,
      height: height,
      width: width,
    );
  }
}