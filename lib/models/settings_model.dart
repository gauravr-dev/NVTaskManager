import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/constants/colors.dart';
import 'package:pomodoro_app/models/task.dart';
import 'package:pomodoro_app/constants/text_styles.dart';

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

class SettingNotifier extends StateNotifier<Settings> {
  SettingNotifier(super.state);

  updateSettings(Settings settings) {
    state = settings;
  }

  reset() {
    state = Settings.defaultSettings;
  }
}

final settingsStateProvider = StateNotifierProvider<SettingNotifier, Settings>(
    (ref) => SettingNotifier(Settings.defaultSettings));
