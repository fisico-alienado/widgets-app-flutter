import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_riverpod_app/presentation/providers/counter_provider.dart';

class CounterScreen extends ConsumerWidget { // ! ConsumerWidget y ConsumerStatefulWidget son las clases de Riverpod

  static const name = 'counter_screen';

  const CounterScreen({super.key});  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final int clickCounter = ref.watch( counterProvider ); // .watch() == estate pendiente del siguiente provider

    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Valor: $clickCounter', style: Theme.of(context).textTheme.titleLarge,),
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {            
          
        },
        child: const Icon(Icons.add),
      )
    );
  }
}