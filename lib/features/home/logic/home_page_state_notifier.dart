import 'package:drop4life/features/home/logic/home_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageStateNotifier extends StateNotifier<HomePageState> {
  HomePageStateNotifier() : super(HomePageState());

  void setLatitude(double value) {
    state = state.copyWith(latitude: value);
  }

  void setLongitude(double value) {
    state = state.copyWith(longitude: value);
  }
}
