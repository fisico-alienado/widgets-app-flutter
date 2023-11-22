import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_riverpod_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {

  static const name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme changer'),
        actions: [
          IconButton(
            icon: Icon( isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleDarkMode();
            }, 
          )
        ],
      ),
      body: const _ThemeChangerView(),
    );

    // ? Forma válida antes de implementar el StateNotifier y StateNotifierProvider de Riverpod. Se puede descomentar para ver que sigue funcionando
    // final isDarkMode = ref.watch( isDarkModeProvider );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Theme changer'),
    //     actions: [
    //       IconButton(
    //         icon: Icon( isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
    //         onPressed: () {
    //           ref.read(isDarkModeProvider.notifier).update((state) => !state);
    //         }, 
    //       )
    //     ],
    //   ),
    //   body: const _ThemeChangerView(),
    // );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<Color> colors = ref.watch( colorListProvider );
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;

    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];

        return RadioListTile(
          title: Row( // * Mi toque personal
            children: [
              Text('Este color: ', style: TextStyle(color: color)),
              Icon(
                Icons.circle,
                color: color,
              )
            ],
          ),
          // title: Text('Este color', style: TextStyle(color: color)); // La forma que eligió Fernando
          subtitle: Text('${color.value}'),
          activeColor: color,
          value: index, 
          groupValue: selectedColor,
          onChanged: (value) {
            ref.read(themeNotifierProvider.notifier).changeColorIndex(index);
          },
        );
      },
    );

    // ? Forma válida antes de implementar el StateNotifier y StateNotifierProvider de Riverpod. Se puede descomentar para ver que sigue funcionando
    // final List<Color> colors = ref.watch( colorListProvider );
    // final int selectedColor = ref.watch( selectedColorProvider );

    // return ListView.builder(
    //   itemCount: colors.length,
    //   itemBuilder: (context, index) {
    //     final Color color = colors[index];

    //     return RadioListTile(
    //       title: Row( // * Mi toque personal
    //         children: [
    //           Text('Este color: ', style: TextStyle(color: color)),
    //           Icon(
    //             Icons.circle,
    //             color: color,
    //           )
    //         ],
    //       ),
    //       // title: Text('Este color', style: TextStyle(color: color)); // La forma que eligió Fernando
    //       subtitle: Text('${color.value}'),
    //       activeColor: color,
    //       value: index, 
    //       groupValue: selectedColor,
    //       onChanged: (value) {
    //         ref.read(selectedColorProvider.notifier).update((state) => index);
    //         // Otra forma
    //         // ref.read(selectedColorProvider.notifier).state = index;
    //       },
    //     );
    //   },
    // );
  }
}