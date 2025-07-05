import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/core/imports/all_imports.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class RequestBloodFormController {
  static String? validPhone(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(requestBloodFormRiverpoodProvider.notifier)
        .validPhone(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? validName(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(requestBloodFormRiverpoodProvider.notifier)
        .fullNameFieldValidationProvider(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? validUnitsNeeded(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(requestBloodFormRiverpoodProvider.notifier)
        .unitsNeededFieldValidationProvider(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? validBloodGroup(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(requestBloodFormRiverpoodProvider.notifier)
        .bloodFieldValidationProvider(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? validCity(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(requestBloodFormRiverpoodProvider.notifier)
        .cityFieldValidationProvider(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static String? validAddress(
    BuildContext context,
    String? value,
    AnimationController animation,
    WidgetRef ref,
  ) {
    var result = ref
        .read(requestBloodFormRiverpoodProvider.notifier)
        .addressFieldValidationProvider(value);
    if (result != null) {
      animation.forward(from: 0);
    }
    return result;
  }

  static void onPressedRequestBlood({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required String name,
    required String email,
    String? bloodGroup,
    required String password,
    required String address,
    String? selectedCity,
    required WidgetRef ref,
  }) {
    if (formKey.currentState?.validate() ?? false) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Request submitted')));
    }
  }

  static Future<Map<String, double>> getLatLngFromAddress(
    String address,
  ) async {
    final apiKey = dotenv.env['GOOGLE_API_KEY']!;
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=$apiKey';
    debugPrint("Geocoding address: $address");
    final response = await http.get(Uri.parse(url));
    debugPrint("Response body: ${response.body}");
    final data = jsonDecode(response.body);

    if (data['status'] == 'OK') {
      final location = data['results'][0]['geometry']['location'];
      return {'latitude': location['lat'], 'longitude': location['lng']};
    } else {
      throw Exception('Failed to get location: ${data['status']}');
    }
  }

  static Future<void> submitBloodRequest({
    required GlobalKey<FormState> formKey,
    required String fullName,
    String? bloodGroup,
    required String unitsNeeded,
    required String phone,
    required String address,
    String? city,
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    if (formKey.currentState?.validate() ?? false) {
      final fullAddress = '$address, $city';
      var requestBloodFormNotifier = ref.read(
        requestBloodFormRiverpoodProvider.notifier,
      );
      requestBloodFormNotifier.setLoading(true);
      try {
        debugPrint('Full address: $fullAddress');
        final location = await getLatLngFromAddress(fullAddress);
        debugPrint('Location: $location');

        await FirebaseFirestore.instance.collection('requestsblood').add({
          'fullname': fullName,
          'bloodGroup': bloodGroup,
          'phone': phone,
          'address': address,
          'unitsneeded': unitsNeeded,
          'city': city,
          'latitude': location['latitude'],
          'longitude': location['longitude'],
          'timestamp': DateTime.now().toIso8601String(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Request submitted successfully.')),
        );
      } catch (e) {
        print('Error submitting request: $e');
      } finally {
        requestBloodFormNotifier.setLoading(false);
      }
    }
  }

  static Future<String> getUserNameFromFirestore(String uid) async {
  final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
  return doc.data()?['name'] ?? '';
}
}
