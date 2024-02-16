import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_app/colors.dart';
import 'package:pomodoro_app/settings_screen.dart';
import 'package:pomodoro_app/text_styles.dart';
import './TimerView.dart';
import './segment_view.dart';
import './settings_model.dart';

enum TaskStatus { start, paused, end, running }

enum TaskPhase { pomodoro, shortBreak, longBreak }

class Task {
  int timeElapsed = 0;
  int longBreakElapsed = 0;
  int shortBreakElapsed = 0;
  TaskStatus status = TaskStatus.start;
  TaskPhase phase = TaskPhase.pomodoro;

  phaseIndex() {
    switch (phase) {
      case TaskPhase.pomodoro:
        return 0;
      case TaskPhase.shortBreak:
        return 1;
      case TaskPhase.longBreak:
        return 2;
      default:
    }
  }

  setPhase(int index) {
    switch (index) {
      case 0:
        phase = TaskPhase.pomodoro;
        break;
      case 1:
        phase = TaskPhase.shortBreak;
        break;
      case 2:
        phase = TaskPhase.longBreak;
        break;
      default:
    }
  }

  statusString() {
    switch (status) {
      case TaskStatus.start:
        return "Start";
      case TaskStatus.paused:
        return "Paused";
      case TaskStatus.end:
        return "Ended";
      case TaskStatus.running:
        return "Pause";
    }
  }

  elapsedTimeForPhase() {
    switch (phase) {
      case TaskPhase.pomodoro:
        return timeElapsed;
      case TaskPhase.shortBreak:
        return shortBreakElapsed;
      case TaskPhase.longBreak:
        return longBreakElapsed;
      default:
        return timeElapsed;
    }
  }

  updateElapsedTimeForPhase(int time) {
    switch (phase) {
      case TaskPhase.pomodoro:
        timeElapsed = time;
        break;
      case TaskPhase.shortBreak:
        shortBreakElapsed = time;
        break;
      case TaskPhase.longBreak:
        longBreakElapsed = time;
        break;
      default:
        timeElapsed = time;
        break;
    }
  }

  changeStatus() {
    switch (status) {
      case TaskStatus.start:
        status = TaskStatus.running;
        break;
      case TaskStatus.running:
        status = TaskStatus.paused;
        break;
      case TaskStatus.paused:
        status = TaskStatus.running;
        break;
      default:
        status = TaskStatus.start;
    }
  }
}

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
        settings.timerValueForPhase(task.phase) - task.elapsedTimeForPhase();

    _timer = Timer.periodic(
      Duration(seconds: _remainingSeconds),
      (Timer timer) {
        if (_remainingSeconds == 0) {
          timer.cancel();
          // change status
        }
        setState(() {
          _remainingSeconds--;
          task.updateElapsedTimeForPhase(
              settings.timerValueForPhase(task.phase) - _remainingSeconds);
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
    settings = ref.watch(settingsStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pomodoro",
          style: TextStyles.h2.copyWith(
            color: AppColors.textTernary,
            fontSize: 24,
          ),
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
                  padding: const EdgeInsets.all(10),
                  child: SegmentView(
                    segmentTitles: const [
                      "Pomodoro",
                      "Short Break",
                      "Long Break",
                    ],
                    onPressed: onChangeValue,
                    textColor: AppColors.textTernary,
                    selectedTextColor: AppColors.background,
                    backgroundColor: AppColors.background,
                    segmentColor: settings.color,
                    selectedSegment: task.phase.index,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TimerView(
                    textColor: AppColors.textTernary,
                    backgroundColor: AppColors.background,
                    progressColor: settings.color,
                    radius: 150,
                    value: settings.timerValueForPhase(task.phase),
                    status: task.statusString(),
                    elapsedValue: task.timeElapsed,
                    changeStatus: (elapsedTime) =>
                        {onChangeStatus(elapsedTime)},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
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
    setState(() {
      task.setPhase(idx);
    });
  }

  onChangeStatus(int elapsedTime) {
    setState(() {
      if (elapsedTime == settings.timerValueForPhase(task.phase)) {
        task.status = TaskStatus.end;
        return;
      }

      task.changeStatus();
    });
  }
}
