import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:pomodoro_app/constants/text_styles.dart';

class SegmentView extends StatelessWidget {
  final void Function(int) onPressed;
  final List<String> segmentTitles;
  final double height = 63;

  //
  // Theme props
  //
  final Color textColor;
  final Color selectedTextColor;
  final Color backgroundColor;
  final Color segmentColor;
  final int selectedSegment;
  final String fontFamily;

  const SegmentView({
    super.key,
    required this.segmentTitles,
    required this.onPressed,
    required this.textColor,
    required this.selectedTextColor,
    required this.backgroundColor,
    required this.segmentColor,
    required this.selectedSegment,
    required this.fontFamily,
  });

  @override
  Widget build(BuildContext context) {
    String selectedSegmentTitle = segmentTitles[selectedSegment];
    double cornerRadius = height / 2;

    return CustomSlidingSegmentedControl<int>(
      initialValue: selectedSegment,
      height: height,
      isStretch: true,
      innerPadding: const EdgeInsets.all(7),
      children: segmentTitles
          .map((e) => Text(
                e,
                style: TextStyles.body2.copyWith(
                  color:
                      selectedSegmentTitle == e ? selectedTextColor : textColor,
                  fontFamily: fontFamily,
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
              0.0,
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
