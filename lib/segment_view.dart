import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:pomodoro_app/text_styles.dart';

class SegmentView extends StatelessWidget {
  final void Function(int) onPressed;
  final List<String> segmentTitles;

  final double cornerRadius = 20;

  //
  // Theme props
  //
  final Color textColor;
  final Color selectedTextColor;
  final Color backgroundColor;
  final Color segmentColor;
  final int selectedSegment;

  const SegmentView(
      {super.key,
      required this.segmentTitles,
      required this.onPressed,
      required this.textColor,
      required this.selectedTextColor,
      required this.backgroundColor,
      required this.segmentColor,
      required this.selectedSegment});

  @override
  Widget build(BuildContext context) {
    String selectedSegmentTitle = segmentTitles[selectedSegment];

    return CustomSlidingSegmentedControl<int>(
      initialValue: selectedSegment,
      children: segmentTitles
          .map((e) => Text(
                e,
                style: TextStyles.body2.copyWith(
                  color:
                      selectedSegmentTitle == e ? selectedTextColor : textColor,
                ),
              ))
          .toList()
          .asMap(),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(cornerRadius),
      ),
      thumbDecoration: BoxDecoration(
        color: segmentColor,
        borderRadius: BorderRadius.circular(cornerRadius),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInToLinear,
      onValueChanged: (v) {
        onPressed(v);
      },
    );
  }
}
