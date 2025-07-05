import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_controller.dart';
import 'package:drop4life/shared/widgets/dropdown_field_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestBloodFormCityDropdownFieldWidget extends ConsumerWidget {
  const RequestBloodFormCityDropdownFieldWidget({
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
    final cityFielName = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.cityFieldName,));
    final cityFielDarkColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldCityColorDark,));
    final cityFielLightColor = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.textFieldCityColorLight,));
    final selectedCity = ref.watch(requestBloodFormRiverpoodProvider.select((value) => value.selectedCity,));
    final notifier = ref.read(requestBloodFormRiverpoodProvider.notifier);
    return DropdownFieldWidget(
      fieldName: cityFielName,
      height: height,
      width: width,
      animation: animation,
      color: Theme.of(context).brightness == Brightness.light
          ? cityFielDarkColor
          : cityFielLightColor,
      items: const [
        'Bahawalpur', 'Lahore', 'Islamabad', 'Karachi',
        'Multan'
      ],
      onChanged: notifier.selectCity,
      validator: (value) => RequestBloodFormController.validCity(context ,value, animationController, ref),
      value: selectedCity?.isEmpty ?? true ? null : selectedCity,
    );
  }
}