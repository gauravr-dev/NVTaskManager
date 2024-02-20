import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:pomodoro_app/constants/colors.dart';
import 'package:pomodoro_app/constants/widget_keys.dart';
import 'package:pomodoro_app/screens/home_screen.dart';

import 'common_test_steps.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Widget getPage() {
    return UncontrolledProviderScope(
      container: ProviderContainer(),
      child: MaterialApp(
        title: 'Pomodoro App',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.secondaryBackground,
        ),
        home: const HomeScreen(
          key: Key("HomeScreen"),
        ),
      ),
    );
  }

  group('home_screen_tests', () {
    testWidgets('Initial timer status is `START`', (tester) async {
      await theAppIsRunning(tester);
      expect(find.text("START"), findsOneWidget);
    });

    testWidgets('Tapped `START` and Status changed to `PAUSE`', (tester) async {
      await theAppIsRunning(tester);
      await tester.tap(find.byKey(timerStartButton));
      await tester.pump();

      expect(find.text("PAUSE"), findsOneWidget);
    });

    testGoldens(
      'My home page',
      (tester) async {
        // Builds the given scenario within a device wrapper
        final builder = DeviceBuilder()
          ..addScenario(
            name: 'Initial Page',
            widget: getPage(),
          )
          ..addScenario(
            name: "Tapped setting button",
            widget: getPage(),
            onCreate: (key) async {
              final finder = find.descendant(
                of: find.byKey(key),
                matching: find.byKey(
                  const Key("SettingsButton"),
                ),
              );
              await expectLater(finder, findsOneWidget);

              await tester.tap(finder);
              await tester.pump();
            },
          );
        await tester.pumpDeviceBuilder(
          builder,
        );
        await tester.pumpAndSettle();
        await screenMatchesGolden(tester, 'my_home_page');
      },
    );
  });
}
