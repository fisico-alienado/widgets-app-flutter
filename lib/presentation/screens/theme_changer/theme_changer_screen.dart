import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_riverpod_app/presentation/providers/theme_provider.dart';

class ThemeChangerScreen extends ConsumerWidget {

  static const name = 'theme_changer_screen';

  const ThemeChangerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch( isDarkModeProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme changer'),
        actions: [
          IconButton(
            icon: Icon( isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: () {
              
            }, 
          )
        ],
      ),
      body: _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<Color> colors = ref.watch( colorListProvider );

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
          groupValue: 0, // TODO
          onChanged: (value) {
            // TODO Notificar el cambio
          },
        );
      },
    );
  }
}