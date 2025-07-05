import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/home/logic/home_page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NearByRequestWidget extends ConsumerWidget {
  final double width;
  final double height;
  final data;
  final user;
  const NearByRequestWidget({
    super.key,
    required this.height,
    required this.width,
    required this.data,
    required this.user,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homePageProvider);
    return SizedBox(
      width: width,
      height: height * 0.42,
      child: FutureBuilder<Widget>(
        future: HomePageController.whichWidget(
          data: data,
          user: user,
          ref: ref,
          height: height,
          width: width,
          context: context
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return Center(child: Text('No widget returned.'));
          }
        },
      ),
    );
  }
}
