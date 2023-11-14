import 'package:flutter/material.dart';
import 'package:widgets_riverpod_app/config/router/app_router.dart';
import 'package:widgets_riverpod_app/config/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Widgets App',
      theme: AppTheme(selectedColor: 0).getTheme(),
      routerConfig: appRouter,
    );
    // ? Caso inicial sin Go_router
    // return MaterialApp(
    //   debugShowCheckedModeBanner: false,
    //   theme: AppTheme(selectedColor: 0).getTheme(),
    //   home: const HomeScreen(),
    //   routes: { // * Si usamos 'Navigator'
    //     '/buttons': (context) => const ButtonsScreen(),
    //     '/cards': (context) => const CardsScreen(),
    //   },
    // );
  }
}
