import 'package:flutter/material.dart';
import 'text_styles.dart';

class NVButton extends StatelessWidget {
  final String buttonText;
  final Image? icon;
  final void Function() onPressed;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double? width;

  const NVButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.textColor,
    required this.backgroundColor,
    required this.height,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: BoxConstraints(
          minWidth: width ?? 120,
          minHeight: height,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(width: 1, color: Colors.transparent),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                    color: textColor,
                    fontFamily: fontFamilyName,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
