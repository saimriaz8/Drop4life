class AiChatPageState {
  bool isLoading;
  List<Map<String, String>> chatHistory;

  AiChatPageState({this.isLoading = false, this.chatHistory = const []});
  AiChatPageState copyWith({
    bool? isLoading,
    List<Map<String, String>>? chatHistory,
  }) {
    return AiChatPageState(
      isLoading: isLoading ?? this.isLoading,
      chatHistory: chatHistory ?? this.chatHistory,
    );
  }
}
