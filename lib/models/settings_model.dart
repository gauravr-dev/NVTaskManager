import 'package:flutter/material.dart';
import 'package:pomodoro_app/constants/colors.dart';
import 'package:pomodoro_app/models/task.dart';
import 'package:pomodoro_app/constants/text_styles.dart';

@immutable
class Settings {
  final String font;
  final int pomodoroTime;
  final int longBreakTime;
  final int shortBreakTime;
  final Color color;

  const Settings(
      {required this.color,
      required this.font,
      required this.pomodoroTime,
      required this.shortBreakTime,
      required this.longBreakTime});

  static var defaultSettings = const Settings(
      color: AppColors.primary,
      font: fontFamilyName1,
      pomodoroTime: 25,
      shortBreakTime: 5,
      longBreakTime: 15);

  timerSecondsForPhase(TaskPhase phase) {
    switch (phase) {
      case TaskPhase.pomodoro:
        return pomodoroTime * 60;
      case TaskPhase.shortBreak:
        return shortBreakTime * 60;
      case TaskPhase.longBreak:
        return longBreakTime * 60;
      default:
        return pomodoroTime * 60;
    }
  }

  Settings copyWith({
    Color? color,
    String? font,
    int? pomodoroTime,
    int? shortBreakTime,
    int? longBreakTime,
  }) {
    return Settings(
      color: color ?? this.color,
      font: font ?? this.font,
      pomodoroTime: pomodoroTime ?? this.pomodoroTime,
      shortBreakTime: shortBreakTime ?? this.shortBreakTime,
      longBreakTime: longBreakTime ?? this.longBreakTime,
    );
  }
}
