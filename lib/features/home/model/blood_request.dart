class BloodRequest {
  final String id;
  final String fullName;
  final String bloodGroup;
  final String phone;
  final String address;
  final String city;
  final String unitsNeeded;
  final double latitude;
  final double longitude;

  BloodRequest({
    required this.id,
    required this.fullName,
    required this.bloodGroup,
    required this.phone,
    required this.address,
    required this.city,
    required this.unitsNeeded,
    required this.latitude,
    required this.longitude,
  });

  factory BloodRequest.fromMap(Map<String, dynamic> data, String docId) {
    return BloodRequest(
      id: docId,
      fullName: data['fullname'] ?? '',
      bloodGroup: data['bloodGroup'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      city: data['city'] ?? '',
      unitsNeeded: data['unitsneeded'] ?? '',
      latitude: data['latitude']?.toDouble() ?? 0.0,
      longitude: data['longitude']?.toDouble() ?? 0.0,
    );
  }
}
