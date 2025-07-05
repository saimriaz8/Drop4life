import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:drop4life/features/home/presentation/widgets/requests_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePageController {
    static List<String> bannerImages = [
      'assets/images/blood_carousel_1.jpeg',
      'assets/images/blood_carousel_2.jpeg',
    ];
    static Future<bool> isLocationPermissionGranted() async {
    PermissionStatus status = await Permission.location.status;
    if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<Position> getUserCurrentLocation({
    required BuildContext context,
  }) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please on your device location')));
      Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You denied the permission allow permission to see near by request',
            ),
          ),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'You denied the permission allow permission to see near by request',
          ),
        ),
      );
    }

    // ✅ Use accuracy setting instead of deprecated `desiredAccuracy`
    final settings = LocationSettings(
      accuracy: LocationAccuracy.best, // or LocationAccuracy.high
    );

    return await Geolocator.getCurrentPosition(locationSettings: settings);
  }

  static Future<Widget> whichWidget({
    required var data,
    required var user,
    required WidgetRef ref,
    required double height,
    required double width,
    required BuildContext context,
  }) async {
    if (await isLocationPermissionGranted() &&
        await Geolocator.isLocationServiceEnabled()) {
      return RequestsListView(data: data, user: user);
    } else {
      return Center(
        child: Column(
          children: [
            Text(
              'Give your location access see nearby request from your location',
            ),
            SizedBox(height: 10, width: width),
            GetStartedButton(
              onPressed: () async {
                Position position = await getUserCurrentLocation(
                  context: context,
                );
                final homePageStateNotifier = ref.read(
                  homePageProvider.notifier,
                );
                homePageStateNotifier.setLatitude(position.latitude);
                homePageStateNotifier.setLongitude(position.longitude);
              },
              text: 'Enable Location',
              height: height,
              width: width,
            ),
          ],
        ),
      );
    }
  }
}


// onPressed: () async {
//             Position position = await getUserCurrentLocation();
//             final homePageStateNotifier = ref.read(homePageProvider.notifier);
//             homePageStateNotifier.setLatitude(position.latitude);
//             homePageStateNotifier.setLongitude(position.longitude);
//           },