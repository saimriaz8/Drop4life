import 'package:flutter/material.dart';
import 'package:drop4life/core/appcolors/app_colors.dart';

typedef FormValidator = String? Function(String?);

class ShakingFormField extends AnimatedWidget {
  final double width;
  final double height;
  final String fieldName;
  final Color color;
  final FormValidator? validator;
  final TextInputType? keyBoardType;
  final TextEditingController textEditingController;
  final IconButton? obscurePasswordButton;
  final bool? obscureText;
  final bool? isReadOnly;
  const ShakingFormField({
    super.key,
    this.validator,
    required this.fieldName,
    required Animation<double> anime,
    required this.height,
    required this.width,
    required this.color,
    required this.textEditingController,
    this.obscurePasswordButton,
    this.keyBoardType,
    this.obscureText,
    this.isReadOnly,
  }) : super(listenable: anime);

  Animation<double> get _animation => listenable as Animation<double>;
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(_animation.value, 0),
      child: SizedBox(
        width: width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldName,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            TextFormField(
              readOnly: isReadOnly ?? false,
              obscureText: obscureText ?? false,
              keyboardType: keyBoardType,
              controller: textEditingController,
              cursorColor:
                  Theme.of(context).brightness == Brightness.light
                      ? AppColors.textDark
                      : AppColors.textLight,
              decoration: InputDecoration(
                suffixIcon: obscurePasswordButton,
                filled: true,
                fillColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.textFieldLight
                        : AppColors.textFieldDark,
                border: InputBorder.none,
              ),
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }
}
