import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:pomodoro_app/main.dart';

Future<void> screenshotVerified(
  WidgetTester tester,
  String scenario,
) async {
  await screenMatchesGolden(tester, scenario);
}

Future<void> theAppIsRendered(WidgetTester tester) async {
  final builder = DeviceBuilder()
    ..addScenario(
      widget: const ProviderScope(
        child: MyApp(
          key: Key("PomodoroApp"),
        ),
      ),
    );
  await tester.pumpDeviceBuilder(builder);
}

Future<void> theAppIsRunning(WidgetTester tester) async {
  await tester.pumpWidget(
    const ProviderScope(
      child: MyApp(
        key: Key("PomodoroApp"),
      ),
    ),
  );
}
