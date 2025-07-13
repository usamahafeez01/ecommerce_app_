import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {
  final ThemeData themeData;
  final bool isDark;

  ThemeState({required this.themeData, required this.isDark});
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
          themeData: ThemeData.light(),
          isDark: false,
        ));

  void toggleTheme() {
    final newIsDark = !state.isDark;
    emit(ThemeState(
      themeData: newIsDark ? ThemeData.dark() : ThemeData.light(),
      isDark: newIsDark,
    ));
  }
}
