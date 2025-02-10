import 'package:messenger/main.dart';

class ThemeModeController extends ChangeNotifier {
  ThemeModeController(BuildContext context);
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  void specificThemeMode(ThemeMode? themeMode) {
    if (themeMode == null) return;
    _themeMode = themeMode;
    notifyListeners();
  }

  void toggleThemeMode() {
    specificThemeMode(
      switch (themeMode) {
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
        ThemeMode.system => ThemeMode.light,
      },
    );
  }
}
