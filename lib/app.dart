import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo_app/create_account_page.dart';
import 'package:memo_app/edit_page.dart';
import 'package:memo_app/login_page.dart';
import 'package:memo_app/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode = ThemeMode.light;

  Future _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode');

    setState(() {
      _themeMode = switch (isDarkMode) {
        null => ThemeMode.system,
        true => ThemeMode.dark,
        false => ThemeMode.light,
      };
    });
  }

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Memo app',
      theme: Brightness.light.theme(),
      darkTheme: Brightness.dark.theme(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

extension on Brightness {
  ThemeData theme({Color? seedColor}) {
    return ThemeData(
      brightness: this,
      useMaterial3: true,
      colorSchemeSeed: seedColor ?? Colors.indigo,
    );
  }
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const EditPage(),
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: "/settings",
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: "/create-account",
      builder: (context, state) => const CreateAccountPage(),
    )
  ],
);
