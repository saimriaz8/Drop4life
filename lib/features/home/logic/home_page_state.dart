class HomePageState {
  final double latitude;
  final double longitude;

  HomePageState({this.latitude = 0.0, this.longitude = 0.0});
  HomePageState copyWith({double? latitude, double? longitude}) {
    return HomePageState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
