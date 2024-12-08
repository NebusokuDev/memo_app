import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:memo_app/create_account_page.dart';
import 'package:memo_app/edit_page.dart';
import 'package:memo_app/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Memo app',
      theme: Brightness.light.theme(),
      darkTheme: Brightness.dark.theme(),
      themeMode: ThemeMode.light,
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
    GoRoute(path: "/", builder: (context, state) => const EditPage()),
    GoRoute(path: "/login", builder: (context, state) => const LoginPage()),
    GoRoute(
      path: "/create-account",
      builder: (context, state) => const CreateAccountPage(),
    )
  ],
);
