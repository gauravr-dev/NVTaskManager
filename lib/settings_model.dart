import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/home_screen.dart';

class Settings {
  String font;
  double pomodoroTime;
  double longBreakTime;
  double shortBreakTime;
  Color color;

  Settings(
      {required this.color,
      required this.font,
      required this.pomodoroTime,
      required this.shortBreakTime,
      required this.longBreakTime});

  static var defaultSettings = Settings(
      color: AppColors.primary,
      font: "KumbhSans",
      pomodoroTime: 25,
      shortBreakTime: 5,
      longBreakTime: 15);

  timerValueForPhase(TaskPhase phase) {
    switch (phase) {
      case TaskPhase.pomodoro:
        return pomodoroTime;
      case TaskPhase.shortBreak:
        return shortBreakTime;
      case TaskPhase.longBreak:
        return longBreakTime;
      default:
        return pomodoroTime;
    }
  }
}

final settingsStateProvider =
    StateProvider<Settings>((ref) => Settings.defaultSettings);
