import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/button.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/settings_model.dart';
import 'package:pomodoro_app/text_input_view.dart';
import 'package:pomodoro_app/text_styles.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  Settings settings = Settings.defaultSettings;

  List<String> availableFonts = [
    "KumbhSans",
    "RobotSlab",
    "SpaceMono",
  ];

  List<Color> availableColors = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.ternary,
  ];

  List<String> timers = ["pomodoro", "short break", "long break"];

  @override
  void initState() {
    super.initState();

    settings = ref.read(settingsStateProvider);
    // oldSettings = settings;
  }

  onChangeTimerValues(String timerName, String textValue) {
    double value = double.parse(textValue);
    switch (timerName) {
      case "pomodoro":
        settings.pomodoroTime = value;
        break;
      case "short break":
        settings.pomodoroTime = value;
        break;
      case "long break":
        settings.pomodoroTime = value;
        break;
      default:
        print("$timerName not supported");
    }
  }

  onApplySettings() {
    ref.read(settingsStateProvider.notifier).state = settings;
    Navigator.of(context).pop();
  }

  onChangeColor(Color color) {
    settings.color = color;
  }

  onChangeFont(String font) {
    settings.font = font;
  }

  onClose() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: NVButton(
          onPressed: () => {onApplySettings()},
          buttonText: "Apply",
          backgroundColor: AppColors.primary,
          textColor: Colors.white,
          height: 53,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(8, 24, 8, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            children: [
              buildHeader(),
              const Divider(
                height: 1,
                color: Colors.black26,
              ),
              buildTimerInputsWidget(timers, settings, onChangeTimerValues),
              const Divider(
                height: 1,
                color: Colors.black26,
                indent: 28,
                endIndent: 28,
              ),
              buildFontSelectionWidget(
                  availableFonts, settings.font, onChangeFont),
              const Divider(
                height: 1,
                color: Colors.black26,
                indent: 28,
                endIndent: 28,
              ),
              buildColorsSelectionWidget(
                  availableColors, settings.color, onChangeColor)
            ],
          ),
        ),
      ),
    );
  }

  buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Settings",
            style: TextStyle(
              fontFamily: fontFamilyName,
              color: AppColors.secondaryBackground,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
              onPressed: () => {onClose()},
              icon: const Icon(
                Icons.close,
                color: AppColors.closeIconColor,
              )),
        ],
      ),
    );
  }

  buildTimerInputsWidget(List<String> timers, Settings settings,
      Function(String, String) changeCallback) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "TIME (MINUTES)",
                  style: TextStyle(
                    fontFamily: fontFamilyName,
                    color: AppColors.secondaryBackground,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  timers.first,
                  style: const TextStyle(
                    fontFamily: fontFamilyName,
                    color: AppColors.background,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TimeInputView(
                  text: settings.pomodoroTime.toString(),
                  height: 40,
                  textCompletion: (text) =>
                      {changeCallback(timers.first, text)},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  timers[1],
                  style: const TextStyle(
                    fontFamily: fontFamilyName,
                    color: AppColors.background,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TimeInputView(
                  text: settings.pomodoroTime.toString(),
                  height: 40,
                  textCompletion: (text) => {
                    //
                    changeCallback(timers[1], text)
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 4, 24, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  timers[2],
                  style: const TextStyle(
                    fontFamily: fontFamilyName,
                    color: AppColors.background,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TimeInputView(
                  text: settings.pomodoroTime.toString(),
                  height: 40,
                  textCompletion: (text) => {
                    //
                    changeCallback(timers[2], text)
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildFontSelectionWidget(List<String> fonts, String selectedFont,
      Function(String) changeFontCallback) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(88, 24, 88, 8),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 4, 24, 12),
            child: Text(
              "FONT",
              style: TextStyle(
                fontFamily: fontFamilyName,
                color: AppColors.secondaryBackground,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: fonts
                  .map(
                    (e) => GestureDetector(
                      onTap: () => {onChangeFont(e)},
                      child: Container(
                        decoration: BoxDecoration(
                            color: e == selectedFont
                                ? AppColors.background
                                : AppColors.textSecondary,
                            shape: BoxShape.circle),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            "Aa",
                            style: TextStyle(
                              fontFamily: e,
                              fontSize: 15,
                              color: e == selectedFont
                                  ? AppColors.textSecondary
                                  : AppColors.background,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }

  buildColorsSelectionWidget(
    List<Color> colors,
    Color selectedColor,
    Function(Color) changeColorCallback,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(88, 24, 88, 8),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 4, 24, 12),
            child: Text(
              "COLOR",
              style: TextStyle(
                fontFamily: fontFamilyName,
                color: AppColors.secondaryBackground,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 5,
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: colors
                  .map(
                    (e) => Container(
                      decoration:
                          BoxDecoration(color: e, shape: BoxShape.circle),
                      child: IconButton(
                        icon: Icon(
                          Icons.check,
                          color: e == selectedColor
                              ? AppColors.background
                              : Colors.transparent,
                        ),
                        onPressed: () => {changeColorCallback(e)},
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}
