import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudalaimani_portfolio/core/theme/bloc/theme_bloc.dart';
import 'package:sudalaimani_portfolio/core/theme/bloc/theme_event.dart';
import 'package:sudalaimani_portfolio/core/theme/bloc/theme_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ThemeBloc Tests', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    test('initial state defaults to dark mode', () {
      final themeBloc = ThemeBloc(prefs: prefs);
      expect(themeBloc.state.themeMode, ThemeMode.dark);
      expect(themeBloc.state.isDarkMode, isTrue);
      themeBloc.close();
    });

    test('ThemeToggled toggles from dark to light mode', () async {
      final themeBloc = ThemeBloc(prefs: prefs);
      expect(themeBloc.state.themeMode, ThemeMode.dark);

      themeBloc.add(const ThemeToggled());
      await expectLater(
        themeBloc.stream,
        emits(const ThemeState(themeMode: ThemeMode.light)),
      );

      expect(themeBloc.state.isDarkMode, isFalse);
      themeBloc.close();
    });

    test('ThemeModeChanged emits custom theme mode', () async {
      final themeBloc = ThemeBloc(prefs: prefs);

      themeBloc.add(const ThemeModeChanged(ThemeMode.light));
      await expectLater(
        themeBloc.stream,
        emits(const ThemeState(themeMode: ThemeMode.light)),
      );

      themeBloc.add(const ThemeModeChanged(ThemeMode.system));
      await expectLater(
        themeBloc.stream,
        emits(const ThemeState(themeMode: ThemeMode.system)),
      );

      themeBloc.close();
    });
  });
}

