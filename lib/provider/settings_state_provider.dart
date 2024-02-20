import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/models/settings_model.dart';

class SettingNotifier extends StateNotifier<Settings> {
  SettingNotifier() : super(Settings.defaultSettings);

  updateSettings(Settings settings) {
    state = settings.copyWith();
  }

  reset() {
    state = Settings.defaultSettings;
  }

  getSettings() {
    return state;
  }
}

final settingsStateProvider = StateNotifierProvider<SettingNotifier, Settings>(
    (ref) => SettingNotifier());
