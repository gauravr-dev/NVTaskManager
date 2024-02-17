import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:pomodoro_app/screens/home_screen.dart';

void main() {
  Widget getPage() {
    return const ProviderScope(
      key: ValueKey("HomeScreen"),
      child: HomeScreen(),
    );
  }

  testGoldens(
    'My home page',
    (tester) async {
      // Builds the given scenario within a device wrapper
      final builder = DeviceBuilder()
        ..addScenario(
          name: 'Initial Page',
          widget: getPage(),
        );

      await tester.pumpDeviceBuilder(
        builder,
        wrapper: materialAppWrapper(
          theme: ThemeData(primaryColor: Colors.red),
        ),
      );

      await screenMatchesGolden(tester, 'my_home_page');
    },
  );
}
