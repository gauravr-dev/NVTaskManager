import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/constants/colors.dart';
import 'package:pomodoro_app/constants/strings.dart';
import 'package:pomodoro_app/screens/settings_screen.dart';
import 'package:pomodoro_app/models/task.dart';
import 'package:pomodoro_app/constants/text_styles.dart';
import '../components/TimerView.dart';
import '../components/segment_view.dart';
import '../models/settings_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Settings settings = Settings.defaultSettings;
  Task task = Task();
  String status = "Start";

  Timer? _timer;
  int _remainingSeconds = 0;

  void startTimer() {
    _remainingSeconds =
        settings.timerSecondsForPhase(task.phase) - task.elapsedTimeForPhase();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_remainingSeconds == 0) {
          timer.cancel();
          // change status
        }
        setState(() {
          _remainingSeconds--;
          task.updateElapsedTimeForPhase(
              settings.timerSecondsForPhase(task.phase) - _remainingSeconds);
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String screenTitle = "pomodoro";

    ref.listen(settingsStateProvider, (previous, next) {
      setState(() {
        settings = next;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          screenTitle,
          style: TextStyles.h2.copyWith(
              color: AppColors.textTernary,
              fontSize: 24,
              fontFamily: settings.font),
        ),
        backgroundColor: AppColors.secondaryBackground,
      ),
      backgroundColor: AppColors.secondaryBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.secondaryBackground,
              AppColors.background.withOpacity(0.3),
              AppColors.background.withOpacity(0.3),
              AppColors.background.withOpacity(0.3),
              AppColors.background.withOpacity(0.3),
              AppColors.secondaryBackground,
            ],
          ),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 45, 24, 20),
                  child: SegmentView(
                    segmentTitles: const [
                      Strings.pomodoro,
                      Strings.shortBreak,
                      Strings.longBreak,
                    ],
                    onPressed: onChangeValue,
                    textColor: AppColors.textTernary,
                    selectedTextColor: AppColors.secondaryBackground,
                    backgroundColor: AppColors.secondaryBackground,
                    segmentColor: settings.color,
                    selectedSegment: task.phase.index,
                    fontFamily: settings.font,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: TimerView(
                    textColor: AppColors.textTernary,
                    backgroundColor: AppColors.background,
                    progressColor: settings.color,
                    radius: 150,
                    value: settings.timerSecondsForPhase(task.phase),
                    status: task.statusString(),
                    elapsedValue: task.elapsedTimeForPhase(),
                    font: settings.font,
                    changeStatus: (elapsedTime) =>
                        {onChangeStatus(elapsedTime)},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(44),
                  child: IconButton(
                      iconSize: 28,
                      onPressed: () => {
                            // Present the settings screen
                            openDialog()
                          },
                      icon: const Icon(Icons.settings)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openDialog() {
    Navigator.of(context).push(
      MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return const SettingsScreen();
        },
        fullscreenDialog: true,
      ),
    );
  }

  onChangeValue(int idx) {
    if (_timer?.isActive ?? true) {
      _timer?.cancel();
      // update timer settings
      task = Task();
    }
    setState(() {
      task.setPhase(idx);
    });
  }

  onChangeStatus(int elapsedTime) {
    setState(() {
      if (elapsedTime == settings.timerSecondsForPhase(task.phase)) {
        task.status = TaskStatus.end;
        return;
      }

      task.changeStatus();
    });

    switch (task.status) {
      case TaskStatus.running:
        startTimer();
        break;
      case TaskStatus.paused:
        _timer?.cancel();
        break;
      case TaskStatus.end:
        _timer?.cancel();
        break;
      default:
    }
  }
}
