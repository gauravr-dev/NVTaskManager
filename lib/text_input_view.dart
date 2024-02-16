import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

class TimeInputView extends StatelessWidget {
  final double height;
  final String text;
  final Function(String) textCompletion;

  final TextEditingController _controller = TextEditingController();

  TimeInputView({
    super.key,
    required this.height,
    required this.text,
    required this.textCompletion,
  }) {
    _controller.text = text;
    _controller.addListener(() => textCompletion(_controller.text));
  }

  final GestureDetector incrementButton = GestureDetector(
      child: const Icon(
        Icons.keyboard_arrow_up_sharp,
        size: 16,
      ),
      onTap: () => {});

  final GestureDetector decrementButton = GestureDetector(
    child: const Icon(
      Icons.keyboard_arrow_down_sharp,
      size: 16,
    ),
    onTap: () => {},
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.timerInputBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 40,
      width: 140,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 12),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                incrementButton,
                decrementButton,
              ],
            ),
          )
        ],
      ),
    );
  }
}
