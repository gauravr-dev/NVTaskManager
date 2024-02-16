import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/home_screen.dart';
import 'package:pomodoro_app/text_styles.dart';

class Settings {
  String font;
  int pomodoroTime;
  int longBreakTime;
  int shortBreakTime;
  Color color;

  Settings(
      {required this.color,
      required this.font,
      required this.pomodoroTime,
      required this.shortBreakTime,
      required this.longBreakTime});

  static var defaultSettings = Settings(
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
}

final settingsStateProvider =
    Provider<Settings>((ref) => Settings.defaultSettings);
