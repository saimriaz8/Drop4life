import 'package:drop4life/features/profile/logic/profile_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePageStateNotifier extends StateNotifier<ProfilePageState> {
  ProfilePageStateNotifier() : super(ProfilePageState());

  void setDonationCount(int donationCount) {
    state = state.copyWith(donateCount: donationCount);
  }

  void setRequestCount(int requestCount) {
    state = state.copyWith(requestCount: requestCount);
  }

  void setAvailableForDonate({required bool value}) {
    state = state.copyWith(isAvailbaleForDonate: value);
  }

  void resetState() {
    state = ProfilePageState();
  }
}
