import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

class RequestBloodButton extends StatelessWidget {
  final double width;
  final String buttonText;
  final GestureTapCallback onPressed;
  const RequestBloodButton({super.key, required this.buttonText, required this.width, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width * 0.9,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max, // Ensures Row fills the width
          children: [
            // Circle background with icon
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.bloodtype, color: Colors.red.shade700, size: 24),
            ),
            const SizedBox(width: 10),
             Expanded(
              // Optional: pushes text to left and avoids overflow
              child: Text(
                buttonText,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.textDark
                          : AppColors.textLight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
