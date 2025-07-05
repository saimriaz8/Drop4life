import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestDetailsPageState {
  final Set<Polyline> polyline;

  RequestDetailsPageState({this.polyline = const {}});

  RequestDetailsPageState copyWith({Set<Polyline>? polyline}) {
    return RequestDetailsPageState(polyline: polyline ?? this.polyline);
  }
}
