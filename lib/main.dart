import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:widgets_riverpod_app/config/router/app_router.dart';
import 'package:widgets_riverpod_app/config/theme/app_theme.dart';
import 'package:widgets_riverpod_app/presentation/providers/theme_provider.dart';

void main() {
  runApp(
    // For widgets to be able to read providers, we need to wrap the entire
    // application in a "ProviderScope" widget.
    // This is where the state of our providers will be stored.
    // Con esto Riverpod podra saber donde esta cada provider que vayamos creando
    const ProviderScope(
      child: MainApp()
    )
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final int selectedColor = ref.watch( selectedColorProvider );
    final isDarkMode = ref.watch( isDarkModeProvider );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Widgets App',
      theme: AppTheme(selectedColor: selectedColor, isDarkMode: isDarkMode).getTheme(),
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
