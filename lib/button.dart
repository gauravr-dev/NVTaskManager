import 'package:flutter/material.dart';

import 'text_styles.dart';

class NVButton extends StatelessWidget {
  final String buttonText;
  final Image? icon;
  final void Function() onPressed;
  const NVButton(
      {super.key,
      required this.onPressed,
      required this.buttonText,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 105,
          minHeight: 40,
        ),
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(width: 1, color: Colors.transparent),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyles.mediumLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
