import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:drop4life/features/aichat/logic/ai_chat_page_controller.dart';
import 'package:drop4life/features/aichat/presentation/widgets/chat_bubble_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AIChatPage extends ConsumerWidget {
  AIChatPage({super.key});

  final TextEditingController _questionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final chatHistory = ref.watch(
      aiChatPageProvider.select((value) => value.chatHistory),
    );
    final isLoading = ref.watch(
      aiChatPageProvider.select((value) => value.isLoading),
    );
    final commonQuestions = [
      "Can I donate blood if I have a tattoo?",
      "How often can I donate blood?",
      "Is blood donation safe?",
      "Who can receive my blood type?",
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('AI Blood Assistant'),
      ),
      body: Padding(
        padding: EdgeInsets.all(size.width * 0.04),
        child: Column(
          children: [
            if (chatHistory.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Common Questions:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        commonQuestions.map((q) {
                          return ActionChip(
                            label: Text(q),
                            onPressed:
                                () => AiChatPageController.askMistralAi(q, ref),
                            backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.red.withOpacity(0.2) : const Color(0xFFEF5350).withAlpha(100),
                          );
                        }).toList(),
                  ),
                  SizedBox(height: size.height * 0.03),
                ],
              ),
            Expanded(
              child: ListView.builder(
                itemCount: chatHistory.length,
                itemBuilder: (context, index) {
                  final item = chatHistory[index];
                  final isUser = item.containsKey("user");
                  return ChatBubbleWidget(
                    message:
                        item[isUser ? 'user' : 'ai'] ?? 'Something went wrong',
                    isUser: isUser,
                    size: size,
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    cursorColor:
                        Theme.of(context).brightness == Brightness.light
                            ? AppColors.textDark
                            : AppColors.textLight,
                    decoration: InputDecoration(
                      hintText: "Type your question...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.textLight
                                  : AppColors.textDark,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed:
                      isLoading
                          ? null
                          : () {
                            if (_questionController.text.trim().isNotEmpty) {
                              AiChatPageController.askMistralAi(
                                _questionController.text.trim(),
                                ref,
                              );
                              _questionController.clear();
                            }
                          },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child:
                      isLoading
                          ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Future<void> _askAI(String question) async {
//     setState(() {
//       _isLoading = true;
//       _chatHistory.add({"user": question});
//     });

//     const apiKey =
//         'replace with open ai api key';
//     const apiUrl = 'https://api.openai.com/v1/completions';

//     try {
//       final response = await http.post(
//         Uri.parse('https://api.openai.com/v1/chat/completions'),
//         headers: {
//           'Authorization': 'Bearer $apiKey',
//           'Content-Type': 'application/json',
//         },
//         body: jsonEncode({
//           "model": "gpt-3.5-turbo",
//           "messages": [
//             {"role": "user", "content": question},
//           ],
//           "max_tokens": 100,
//         }),
//       );

//       final data = jsonDecode(response.body);

//       if (response.statusCode == 200 &&
//           data['choices'] != null &&
//           data['choices'].isNotEmpty) {
//         final reply =
//             data['choices'][0]['message']['content'].toString().trim();
//         print("AI Reply: $reply");
//       } else {
//         print("❌ Failed to get response from OpenAI:");
//         print("Status Code: ${response.statusCode}");
//         print("Response: ${response.body}");
//       }
//     } catch (e) {
//       setState(() {
//         _chatHistory.add({"ai": e.toString()});
//         _isLoading = false;
//       });
//     }
//   }



// Widget _buildChatBubble(String message, bool isUser, Size size) {
  //   return Align(
  //     alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 4),
  //       padding: EdgeInsets.all(size.width * 0.04),
  //       decoration: BoxDecoration(
  //         color: isUser ? Colors.redAccent : Colors.red.withOpacity(0.1),
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       constraints: BoxConstraints(maxWidth: size.width * 0.75),
  //       child: Text(
  //         message,
  //         style: TextStyle(
  //           color: isUser ? Colors.white : Colors.black87,
  //           fontSize: 15,
  //         ),
  //       ),
  //     ),
  //   );
  // }