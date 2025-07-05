import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/home/model/blood_request.dart';
import 'package:drop4life/features/requestdetails/logic/request_detail_page_state_notifier.dart';
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
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('requestsblood')
          .doc(request.id) // make sure request has an ID
          .collection('donation_interests')
          .add({
            'donorName': donorData['name'],
            'donorEmail': donorData['email'], // or actual user phone
            'donorTime': DateTime.now().toIso8601String(),
          });

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
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your willingness to donate has been shared.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'If the recipient accepts, they’ll reach out to you soon. '
                    'Thank you for being a real-life hero. 🩸',
                    style: TextStyle(fontSize: 14,),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark ? AppColors.textLight : AppColors.textDark,
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
