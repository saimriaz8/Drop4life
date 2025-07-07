import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/home/model/blood_request.dart';
import 'package:drop4life/features/requestdetails/presentation/request_detail_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class RequestsListView extends ConsumerWidget {
  final User? user;
  final Map<String, dynamic> data; // Assumes data contains user's current lat/lng

  const RequestsListView({super.key, required this.data, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double userLatitude = ref.watch(
      homePageProvider.select((value) => value.latitude),
    );
    final double userLongitude = ref.watch(
      homePageProvider.select((value) => value.longitude),
    );
    const double radiusInKm = 10;

    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('requestsblood')
              .orderBy('timestamp', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(color: AppColors.primaryColor,));
        } else {
          final allRequests =
              snapshot.data!.docs
                  .map(
                    (doc) => BloodRequest.fromMap(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    ),
                  )
                  .toList();

          // Filter nearby requests
          final nearbyRequests =
              allRequests.where((request) {
                final double requestLatitude = request.latitude;
                final double requestLongitude = request.longitude;

                final double distanceInMeters = Geolocator.distanceBetween(
                  userLatitude,
                  userLongitude,
                  requestLatitude,
                  requestLongitude,
                );

                return distanceInMeters <= radiusInKm * 1000 && request.fullName.toLowerCase() != data['name'].toString().toLowerCase();
              }).toList();

          return nearbyRequests.isEmpty
              ? Center(child: Text('No nearby requests found.'))
              : ListView.builder(
                itemCount: nearbyRequests.length,
                itemBuilder: (context, index) {
                  final request = nearbyRequests[index];
                  return ListTile(
                    title: Text(request.fullName),
                    subtitle: Text('${request.bloodGroup} • ${request.city}'),
                    trailing: Text(
                      'See Details',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      var record = (user, data, request);
                      GoRouter.of(
                        context,
                      ).push(RequestDetailPage.pageName, extra: record);
                    },
                  );
                },
              );
        }
      },
    );
  }
}
