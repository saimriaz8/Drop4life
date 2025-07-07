import 'package:drop4life/features/aichat/logic/ai_chat_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AiChatPageStateNotifier extends StateNotifier<AiChatPageState> {
  AiChatPageStateNotifier() : super(AiChatPageState());

  void setLoading({required bool value}) {
    state = state.copyWith(isLoading: value);
  }

  void setChatHistory({required Map<String, String> latestChat}) {
    List<Map<String, String>> chatsList = [...state.chatHistory, latestChat];
    state = state.copyWith(chatHistory: chatsList);
  }

  void resetChat() {
    state = state.copyWith(chatHistory: []);
  }
}
