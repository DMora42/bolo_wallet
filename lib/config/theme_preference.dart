import 'user_preferences.dart';

class ThemePreferences extends UserPreferences {
  static const themeKey = 'themeKey';

  setTheme(bool value) async {
    await writeBool(themeKey, value);
  }

  getTheme() async {
    return await readBool(themeKey) ?? false;
  }
}
