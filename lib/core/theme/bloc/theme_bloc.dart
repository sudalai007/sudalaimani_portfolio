import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_constants.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences? _prefs;

  ThemeBloc({SharedPreferences? prefs})
      : _prefs = prefs,
        super(const ThemeState()) {
    on<ThemeInitialized>(_onThemeInitialized);
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<ThemeToggled>(_onThemeToggled);

    add(const ThemeInitialized());
  }

  void _onThemeInitialized(
    ThemeInitialized event,
    Emitter<ThemeState> emit,
  ) {
    final prefs = _prefs;
    if (prefs == null) return;
    final savedMode = prefs.getString(AppConstants.themePreferenceKey);
    if (savedMode != null) {
      if (savedMode == 'light') {
        emit(state.copyWith(themeMode: ThemeMode.light));
      } else if (savedMode == 'dark') {
        emit(state.copyWith(themeMode: ThemeMode.dark));
      } else if (savedMode == 'system') {
        emit(state.copyWith(themeMode: ThemeMode.system));
      }
    }
  }

  Future<void> _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<ThemeState> emit,
  ) async {
    emit(state.copyWith(themeMode: event.themeMode));
    await _persistTheme(event.themeMode);
  }

  Future<void> _onThemeToggled(
    ThemeToggled event,
    Emitter<ThemeState> emit,
  ) async {
    final nextMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    emit(state.copyWith(themeMode: nextMode));
    await _persistTheme(nextMode);
  }

  Future<void> _persistTheme(ThemeMode mode) async {
    final prefs = _prefs;
    if (prefs == null) return;
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await prefs.setString(AppConstants.themePreferenceKey, value);
  }
}
