import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/home/model/blood_request.dart';
import 'package:drop4life/features/requestdetails/logic/request_detail_page_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends ConsumerWidget {
  final BloodRequest bloodRequest;
  const GoogleMapWidget({super.key, required this.bloodRequest});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageState = ref.watch(homePageProvider);
    final requestDetailPageStateNotifier = ref.watch(
      requestDetailPageProvider.notifier,
    );
    LatLng userLocation = LatLng(
      homePageState.latitude,
      homePageState.longitude,
    );
    LatLng requestLocation = LatLng(
      bloodRequest.latitude,
      bloodRequest.longitude,
    );
    RequestDetailPageController.userAndRequestPolyLine(
      requestLocation: requestLocation,
      userLocation: userLocation,
      requestDetailPageStateNotifier: requestDetailPageStateNotifier,
    );

    final polyLine = ref.watch(
      requestDetailPageProvider.select((value) => value.polyline),
    );
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: userLocation, zoom: 14),
      markers: {
        Marker(
          markerId: MarkerId('userLocation'),
          position: userLocation,
          infoWindow: InfoWindow(title: 'You'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
        Marker(
          markerId: MarkerId('requestLocation'),
          position: requestLocation,
          infoWindow: InfoWindow(title: bloodRequest.fullName),
        ),
      },
      polylines: polyLine,
    );
  }
}
