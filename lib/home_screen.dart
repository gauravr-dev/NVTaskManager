import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './TimerView.dart';
import './segment_view.dart';
import './settings.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {

Settings settings = Settings.default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SafeArea(
              child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: SegmentView(segmentTitles: const [
              "Pomodoro",
              "Long Break",
              "Short Break",
            ], onPressed: changeValue),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TimerView(),
          )
        ],
      ))),
    );
  }

  void changeValue(int index) {}
}
