import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/screens/home_screen.dart';
import 'package:project/screens/details_screen.dart';
import 'package:project/screens/imprint_screen.dart';
import 'package:project/screens/settings_screen.dart';
import 'package:project/themes/light_theme.dart';
import 'package:project/themes/dark_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  void _toggleDarkMode(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
      _saveThemeMode(isDark);
    });
  }

  Future<void> _saveThemeMode(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University Course Management',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
        '/imprint': (context) => ImprintScreen(),
        '/settings': (context) => SettingsScreen(onThemeChanged: _toggleDarkMode, isDarkMode: _isDarkMode),
      },
    );
  }
}
