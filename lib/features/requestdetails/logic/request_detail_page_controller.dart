import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/home/model/blood_request.dart';
import 'package:drop4life/features/profile/logic/profile_page_state_notifier.dart';
import 'package:drop4life/features/requestdetails/logic/request_detail_page_state_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class RequestDetailPageController {
  static Set<Polyline> polyLine = {};
  static Future<List<LatLng>> getRouteCoordinates(
    LatLng start,
    LatLng end,
  ) async {
    String apiKey = dotenv.env['GOOGLE_API_KEY']!;
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    debugPrint('RESPONSE: ${response.body}');
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      final encodedPoints = data['routes'][0]['overview_polyline']['points'];
      final List<PointLatLng> decodedPoints = PolylinePoints().decodePolyline(
        encodedPoints,
      );
      return decodedPoints
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    } else {
      throw Exception("Failed to get route: ${data['status']}");
    }
  }

  static Future<void> userAndRequestPolyLine({
    required LatLng requestLocation,
    required LatLng userLocation,
    required RequestDetailPageStateNotifier requestDetailPageStateNotifier,
  }) async {
    final point = await getRouteCoordinates(userLocation, requestLocation);
    requestDetailPageStateNotifier.setPolyline({
      Polyline(
        polylineId: PolylineId('route'),
        color: AppColors.primaryColor,
        width: 4,
        points: point,
      ),
    });
  }

  static Future<void> onPressedDonate({
    required BuildContext context,
    required BloodRequest request,
    required Map<String, dynamic> donorData,
    required User? user,
    required ProfilePageStateNotifier profilePageStateNotifier,
  }) async {
    try {
      // await FirebaseFirestore.instance
      //     .collection('requestsblood')
      //     .doc(request.id) // make sure request has an ID
      //     .collection('donation_interests')
      //     .add({
      //       'donorName': donorData['name'],
      //       'donorEmail': donorData['email'], // or actual user phone
      //       'donorTime': DateTime.now().toIso8601String(),
      //     });

      // Optionally send a notification using Firebase Cloud Functions

      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: Row(
                children: [
                  Icon(Icons.favorite, color: Colors.redAccent),
                  SizedBox(width: 8),
                  Text(
                    'Life Saved!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your willingness to donate has been shared.',
                    style: TextStyle(fontSize: 17),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The blood request has been removed and the recipient has been notified '
                    'with your contact details. They will reach out to you directly via phone or email if they wish to proceed.\n\n'
                    'Thank you for stepping up and being a real-life hero. 🩸',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    GoRouter.of(context).pop();
                    await FirebaseFirestore.instance
                        .collection('requestsblood')
                        .doc(request.id)
                        .delete();
                    if (user != null) {
                      final uId = user.uid;
                      final userDoc = FirebaseFirestore.instance
                          .collection('users')
                          .doc(uId);
                      final snapshot = await userDoc.get();

                      if (!snapshot.exists) {
                        await userDoc.set({
                          'email': user.email,
                          'name': user.displayName ?? '',
                          'requestCount': 0,
                          'donationCount': 0,
                          'createdAt': FieldValue.serverTimestamp(),
                        });
                      }
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uId)
                          .update({'donationCount': FieldValue.increment(1)});
                      final doc =
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uId)
                              .get();
                      if (doc.exists) {
                        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                        
                        profilePageStateNotifier.setDonationCount(
                          data['donationCount'] ?? 0,
                        );
                        profilePageStateNotifier.setRequestCount(
                          data['requestCount'] ?? 0,
                        );
                      }
                    }
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }
}
