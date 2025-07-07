import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/home/model/blood_request.dart';
import 'package:drop4life/features/requestdetails/presentation/widgets/google_map_widget.dart';
import 'package:drop4life/features/requestdetails/logic/request_detail_page_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestDetailPage extends ConsumerWidget {
  final (User?, Map<String, dynamic>, BloodRequest) record;
  static const String pageName = '/requestdetails';
  const RequestDetailPage({super.key, required this.record});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = record.$1;
    Map<String, dynamic> data = record.$2;
    BloodRequest request = record.$3;
    var size = MediaQuery.sizeOf(context);
    var Size(:width, :height) = size;
    height -= kToolbarHeight;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            Theme.of(context).brightness == Brightness.dark
                ? AppColors.textLight
                : AppColors.textDark,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(title: Text('Request Details')),
          body: Stack(
            children: [
              // 🗺️ Google Map (top)
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: width,
                  height: height * 0.575,
                  child: GoogleMapWidget(bloodRequest: request),
                ),
              ),

              // 📋 Stylish scrollable bottom details
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: width,
                  height: height * 0.37,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Blood Request Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color:
                                  Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.textDark
                                      : AppColors.textLight,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        DetailRow(
                          icon: Icons.person,
                          label: "Full Name",
                          value: request.fullName,
                        ),
                        DetailRow(
                          icon: Icons.water_drop,
                          label: "Blood Group",
                          value: request.bloodGroup,
                        ),
                        DetailRow(
                          icon: Icons.bloodtype,
                          label: "Units Needed",
                          value: request.unitsNeeded,
                        ),
                        DetailRow(
                          icon: Icons.phone,
                          label: "Phone",
                          value: request.phone,
                        ),
                        DetailRow(
                          icon: Icons.location_city,
                          label: "City",
                          value: request.city,
                        ),
                        DetailRow(
                          icon: Icons.location_on,
                          label: "Address",
                          value: request.address,
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed:
                                () =>
                                    RequestDetailPageController.onPressedDonate(
                                      context: context,
                                      request: request,
                                      donorData: data,
                                      user: user,
                                      profilePageStateNotifier: ref.read(profilePageProvider.notifier),
                                    ),
                            icon: Icon(Icons.favorite),
                            label: Text("I Want to Donate"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.textLight,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "$label: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.textDark
                        : AppColors.textLight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.textDark
                        : AppColors.textLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
