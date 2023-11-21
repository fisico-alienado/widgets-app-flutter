import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_riverpod_app/presentation/providers/counter_provider.dart';
import 'package:widgets_riverpod_app/presentation/providers/theme_provider.dart';

class CounterScreen extends ConsumerWidget { // ! ConsumerWidget y ConsumerStatefulWidget son las clases de Riverpod

  static const name = 'counter_screen';

  const CounterScreen({super.key});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final int clickCounter = ref.watch( counterProvider ); // .watch() == estate pendiente del siguiente provider
    final bool isDarkMode = ref.watch( isDarkModeProvider );

    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('Counter Screen'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              ref.read(counterProvider.notifier).state = 0;
            },
          ),
          IconButton(
            icon: Icon( isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
            onPressed: () {
              ref.read(isDarkModeProvider.notifier).update((state) => !state);
            }, 
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$clickCounter',
                style: const TextStyle(
                    fontSize: 160, fontWeight: FontWeight.w100)),
            Text('Click${clickCounter == 1 ? '' : 's'}', style: const TextStyle(fontSize: 25)),
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              ref.read(counterProvider.notifier).state++;
              // * Otra forma valida
              // ref.read(counterProvider.notifier).update((state) => state + 1);
            },
          ),

          // Para agregar una SEPARACION
          const SizedBox(height: 10),

          FloatingActionButton(
            child: const Icon(Icons.remove),
            onPressed: () {
              if (clickCounter == 0) return; // QUE NO HAGA NADA MAS SI EL VALOR ES CERO
              ref.read(counterProvider.notifier).state--;
              // * Otra forma valida
              // ref.read(counterProvider.notifier).update((state) => state - 1);
            },
          ),
        ],
      )
    );
  }
}