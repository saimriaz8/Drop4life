import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationStateNotifier extends StateNotifier<int> {
  BottomNavigationStateNotifier() : super(0);
  
  void onPressedNavItem(int i) {
    state = i;
  }
}