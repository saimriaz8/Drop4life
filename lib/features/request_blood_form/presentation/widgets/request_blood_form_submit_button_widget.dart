import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_controller.dart';
import 'package:drop4life/shared/widgets/circular_progress_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmitRequestButton extends ConsumerWidget {
  const SubmitRequestButton({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.nameController,
    required this.unitsController,
    required this.addressController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController nameController;
  final TextEditingController unitsController;
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBloodGroup = ref.watch(
      requestBloodFormRiverpoodProvider.select(
        (value) => value.selectedBloodGroup,
      ),
    );
    final selectedCity = ref.watch(
      requestBloodFormRiverpoodProvider.select((value) => value.selectedCity),
    );
    final isLoading = ref.watch(
      requestBloodFormRiverpoodProvider.select((value) => value.isLoading),
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.65,
      child: ElevatedButton(
        onPressed: () async {
          await RequestBloodFormController.submitBloodRequest(
            context: context,
            formKey: formKey,
            fullName: nameController.text.trim(),
            phone: phoneController.text.trim(),
            unitsNeeded: unitsController.text.trim(),
            address: addressController.text.trim(),
            bloodGroup: selectedBloodGroup,
            city: selectedCity,
            ref: ref,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child:
            isLoading
                ? CircularProgressIndicatorWidget()
                : const Text(
                  'Submit Request',
                  style: TextStyle(color: Colors.white),
                ),
      ),
    );
  }
}
