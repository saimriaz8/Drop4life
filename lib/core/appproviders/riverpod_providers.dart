import 'package:drop4life/features/auth/sign_in/logic/sign_in_form_state.dart';
import 'package:drop4life/features/auth/sign_in/logic/sign_in_form_state_notifier.dart';
import 'package:drop4life/features/auth/sign_up/logic/sign_up_form_notifier.dart';
import 'package:drop4life/features/auth/sign_up/logic/sign_up_form_state.dart';
import 'package:drop4life/features/bottom_navigation/logic/bottom_navigation_state_notifier.dart';
import 'package:drop4life/features/aichat/logic/ai_chat_page_state.dart';
import 'package:drop4life/features/aichat/logic/ai_chat_page_state_notifier.dart';
import 'package:drop4life/features/home/logic/home_page_state.dart';
import 'package:drop4life/features/home/logic/home_page_state_notifier.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_state.dart';
import 'package:drop4life/features/request_blood_form/logic/request_blood_form_state_notifier.dart';
import 'package:drop4life/features/requestdetails/logic/request_detail_page_state_notifier.dart';
import 'package:drop4life/features/requestdetails/logic/request_details_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInFormRiverpodProvider =
    StateNotifierProvider<SignInFormNotifier, SignInFormState>((ref) {
      return SignInFormNotifier();
    });
final signUpFormRiverpodProvider =
    StateNotifierProvider<SignUpFormNotifier, SignUpFormState>((ref) {
      return SignUpFormNotifier();
    });

final requestBloodFormRiverpoodProvider =
    StateNotifierProvider<RequestBloodFormNotifier, RequestBloodFormState>((
      ref,
    ) {
      return RequestBloodFormNotifier();
    });

final bottomNavigationRiverpdProvider =
    StateNotifierProvider<BottomNavigationStateNotifier, int>((ref) {
      return BottomNavigationStateNotifier();
    });

final aiChatPageProvider =
    StateNotifierProvider<AiChatPageStateNotifier, AiChatPageState>((ref) {
      return AiChatPageStateNotifier();
    });

final homePageProvider =
    StateNotifierProvider<HomePageStateNotifier, HomePageState>((ref) {
      return HomePageStateNotifier();
    });

    final requestDetailPageProvider =
    StateNotifierProvider<RequestDetailPageStateNotifier, RequestDetailsPageState>((ref) {
      return RequestDetailPageStateNotifier();
    });


