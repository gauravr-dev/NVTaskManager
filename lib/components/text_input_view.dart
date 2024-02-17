import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/colors.dart';

class TimeInputView extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Function(String) textCompletion;
  final TextEditingController _controller = TextEditingController();

  late final GestureDetector? _decrementButton;
  late final GestureDetector? _incrementButton;

  TimeInputView({
    super.key,
    required this.height,
    required this.width,
    required this.text,
    required this.textCompletion,
  }) {
    _controller.text = text;
    _controller.addListener(() => textCompletion(_controller.text));

    _decrementButton = GestureDetector(
      onTap: _decrementValue,
      child: const Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 16,
      ),
    );

    _incrementButton = GestureDetector(
      onTap: _incrementValue,
      child: const Icon(
        Icons.keyboard_arrow_up_sharp,
        size: 16,
      ),
    );
  }

  void _incrementValue() {
    int value = int.parse(_controller.text);
    ++value;
    _controller.text = value.toString();
  }

  void _decrementValue() {
    int value = int.parse(_controller.text);
    --value;
    _controller.text = value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.timerInputBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      height: height,
      width: width,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
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
                _incrementButton!,
                _decrementButton!,
              ],
            ),
          )
        ],
      ),
    );
  }
}
