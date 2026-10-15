import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  static final AppSettings _instance = AppSettings._internal();
  factory AppSettings() => _instance;
  AppSettings._internal();

  ThemeMode _themeMode = ThemeMode.system;
  String _lastFrom = 'RUB';
  String _lastTo = 'USD';

  ThemeMode get themeMode => _themeMode;
  String get lastFrom => _lastFrom;
  String get lastTo => _lastTo;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = ThemeMode.values[prefs.getInt('theme') ?? 0];
    _lastFrom = prefs.getString('lastFrom') ?? 'RUB';
    _lastTo = prefs.getString('lastTo') ?? 'USD';
    notifyListeners();
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    _saveTheme();
    notifyListeners();
  }

  void setLastCurrency(String from, String to) {
    _lastFrom = from;
    _lastTo = to;
    _saveCurrency();
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', _themeMode.index);
  }

  Future<void> _saveCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastFrom', _lastFrom);
    await prefs.setString('lastTo', _lastTo);
  }
}