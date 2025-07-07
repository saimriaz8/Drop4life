import 'package:drop4life/core/imports/all_imports.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isUser;
  final Size size;
  const ChatBubbleWidget({
    super.key,
    required this.message,
    required this.isUser,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(size.width * 0.04),
        decoration: BoxDecoration(
          color: isUser ? Colors.redAccent : Theme.of(context).brightness == Brightness.dark ? const Color(0xFFEF5350).withAlpha(100) : const Color(0xFFEF5350).withAlpha(25),
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(maxWidth: size.width * 0.75),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : Theme.of(context).brightness == Brightness.light ? Colors.black87 : Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
