import 'package:drop4life/core/appcolors/app_colors.dart';
import 'package:drop4life/core/imports/all_imports.dart';

typedef OnChanged = void Function(String?);

class DropdownFieldWidget extends AnimatedWidget {
  final String? value;
  final List<String> items;
  final OnChanged onChanged;
  final FormFieldValidator validator;
  final double width;
  final double height;
  final String fieldName;
  final Color color;
  const DropdownFieldWidget({
    super.key,
    required this.items,
    this.value,
    required this.fieldName,
    required this.color,
    required this.onChanged,
    required this.validator,
    required this.height,
    required this.width,
    required Animation<double> animation,
  }) : super(listenable: animation);

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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color
              ),
            ),
            DropdownButtonFormField<String>(
              value: value,
              items:
                  items.map((group) {
                    return DropdownMenuItem(value: group, child: Text(group));
                  }).toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
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
