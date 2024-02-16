import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pomodoro_app/colors.dart';

class TimerView extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color progressColor;
  final double radius;
  final int value;
  final String status;
  final int elapsedValue;
  final String font;
  final Function(int) changeStatus;

  const TimerView({
    super.key,
    required this.textColor,
    required this.backgroundColor,
    required this.progressColor,
    required this.radius,
    required this.value,
    required this.status,
    required this.elapsedValue,
    required this.font,
    required this.changeStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: AlignmentDirectional.centerStart,
          end: AlignmentDirectional.centerEnd,
          colors: [
            AppColors.secondaryBackground,
            AppColors.background,
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              shape: BoxShape.circle, color: AppColors.secondaryBackground),
          child: CircularPercentIndicator(
            radius: radius,
            lineWidth: 12.0,
            percent: elapsedProgress(),
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  elapsedTime(),
                  style: TextStyle(
                    color: textColor,
                    fontFamily: font,
                    fontSize: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => {changeStatus(elapsedValue)},
                  child: Text(
                    status.toUpperCase(),
                    style: TextStyle(
                      color: textColor,
                      fontFamily: font,
                      fontSize: 14,
                      letterSpacing: 15,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            progressColor: progressColor,
          ),
        ),
      ),
    );
  }

  // Value and elapsedValues are minutes
  elapsedProgress() {
    if (elapsedValue == 0) {
      return 0.0;
    }
    return elapsedValue / value;
  }

  elapsedTime() {
    int remainingSeconds = value - elapsedValue;
    int remMinutes = remainingSeconds ~/ 60;
    int remSeconds = (remainingSeconds % 60);

    return "$remMinutes : $remSeconds";
  }
}
