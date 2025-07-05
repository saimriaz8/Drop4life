import 'dart:convert';
import 'package:drop4life/core/appproviders/riverpod_providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class AiChatPageController {
  static Future<void> askMistralAi(String question, WidgetRef ref) async {
    const apiUrl = 'https://openrouter.ai/api/v1/chat/completions';
    String apiKey = dotenv.env['OPEN_ROUTER_API_KEY']!;
    final aiChatNotifier = ref.read(aiChatPageProvider.notifier);
    aiChatNotifier.setLoading(value: true);
    aiChatNotifier.setChatHistory(latestChat: {'user': question});
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://drop4life.flutter', // App or website name
          'X-Title': 'Drop4Life AI Chat',
        },
        body: jsonEncode({
          "model": "mistralai/mistral-7b-instruct",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a helpful AI assistant specialized in medical advice and blood donation. Only answer questions related to these topics. Politely decline anything else.",
            },
            {"role": "user", "content": question},
          ],
          "max_tokens": 200,
        }),
      );

      Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          data['choices'] != null &&
          data['choices'].isNotEmpty) {
        String reply =
            data['choices'][0]['message']['content'].toString().trim();
        aiChatNotifier.setLoading(value: false);
        aiChatNotifier.setChatHistory(latestChat: {'ai': reply});
      } else {
        aiChatNotifier.setLoading(value: false);
        aiChatNotifier.setChatHistory(
          latestChat: {
            'ai':
                "⚠️ AI could not respond. ${data['error']?['message'] ?? 'Please try again later.'}",
          },
        );
      }
    } catch (e) {
      aiChatNotifier.setLoading(value: false);
      aiChatNotifier.setChatHistory(latestChat: {'ai': e.toString()});
    }
  }
}