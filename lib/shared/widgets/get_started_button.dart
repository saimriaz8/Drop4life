import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:flutter/material.dart';

typedef ButtonTap = Function();

class GetStartedButton extends StatelessWidget {
  final double width;
  final double height;
  final ButtonTap onPressed;
  final String text;
  const GetStartedButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          backgroundColor:  WidgetStatePropertyAll(AppColors.primaryColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        child:  Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}
