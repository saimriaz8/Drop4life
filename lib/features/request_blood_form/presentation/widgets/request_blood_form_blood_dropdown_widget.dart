import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_controller.dart';
import 'package:drop4life/shared/widgets/dropdown_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestBloodFormBloodGroupDropdownFieldWidget extends ConsumerWidget {
  const RequestBloodFormBloodGroupDropdownFieldWidget({
    super.key,
    required this.animation,
    required this.height,
    required this.width,
    required this.animationController,
  });

  final Animation<double> animation;
  final AnimationController animationController;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloodFieldName = ref.watch(
      requestBloodFormRiverpoodProvider.select((value) => value.bloodFieldName),
    );
    final bloodFieldDarkColor = ref.watch(
      requestBloodFormRiverpoodProvider.select(
        (value) => value.textFieldBloodColorDark,
      ),
    );
    final bloodFieldLightColor = ref.watch(
      requestBloodFormRiverpoodProvider.select(
        (value) => value.textFieldBloodColorLight,
      ),
    );
    final bloodGroup = ref.watch(
      requestBloodFormRiverpoodProvider.select(
        (value) => value.selectedBloodGroup,
      ),
    );
    final notifier = ref.watch(requestBloodFormRiverpoodProvider.notifier);
    return DropdownFieldWidget(
      fieldName: bloodFieldName,
      height: height,
      width: width,
      animation: animation,
      color:
          Theme.of(context).brightness == Brightness.light
              ? bloodFieldDarkColor
              : bloodFieldLightColor,
      items: const ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'],
      onChanged: notifier.selectGroup,
      validator:
          (value) => RequestBloodFormController.validBloodGroup(
            context,
            value,
            animationController,
            ref,
          ),
      value: bloodGroup?.isEmpty ?? true ? null : bloodGroup,
    );
  }
}
