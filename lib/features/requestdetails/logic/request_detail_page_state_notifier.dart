import 'package:drop4life/features/requestdetails/logic/request_details_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestDetailPageStateNotifier
    extends StateNotifier<RequestDetailsPageState> {
  RequestDetailPageStateNotifier() : super(RequestDetailsPageState());

  void setPolyline(Set<Polyline> polyline) {
    state = state.copyWith(polyline: polyline);
  }
}
