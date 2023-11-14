import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProgressScreen extends StatelessWidget {

  static const name = 'progress_screen';

  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('Progress Indicators'),
      ),
      body: const _ProgressView(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_back_ios_new_rounded),
        onPressed: () {
          context.pop(); // ! Para volver a la pantalla anterior. Esta es la forma de hacerlo con Go Router
          // Navigator.of(context).pop(...) // * Si usamos 'Navigator'
        },
      ),
    );
  }
}

class _ProgressView extends StatelessWidget {
  const _ProgressView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          Text('Circular progress indicators'),
          SizedBox(height: 10),
          CircularProgressIndicator(strokeWidth: 2, backgroundColor: Colors.black45), // ? Este se muestra hasta que le digamos que se quite

          SizedBox(height: 20),
          Text('Circular progress indicator controlado'), // ? Este se va a poder controlar de acuerdo al porcentaje de carga
          SizedBox(height: 10),

        ]
      ),
    );
  }
}