import 'package:flutter/material.dart';
import 'package:pomodoro_app/colors.dart';

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
      font: "font",
      pomodoroTime: 25,
      shortBreakTime: 5,
      longBreakTime: 15);
}
