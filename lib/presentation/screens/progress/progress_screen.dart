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
          Text('Circular y Linear progress indicator controlado'), // ? Este se va a poder controlar de acuerdo al porcentaje de carga
          SizedBox(height: 10),
          _ControlledProgressIndicator()
        ]
      ),
    );
  }
}

class _ControlledProgressIndicator extends StatelessWidget {
  const _ControlledProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder( // ! 'Stream' indica flujo de información; '...Builder indica que es un widget que se va a generar en tiempo de ejecucion
      stream: Stream.periodic(const Duration(milliseconds: 300), (value) {
        return (value * 2) / 100; // para obtener valores desde 0.0 a 1.0, que son los que cogen los progress indicators
      }).takeWhile((value) => value < 100), // va a emitir valores constantemente cada 300 ms hasta que le digamos basta con .take() o .takeWhile()
      builder: ((context, snapshot) { // ? 'context' == BuildContext y 'snapshot' == los valores que va emitiendo el stream
        
        final progressValue = snapshot.data ?? 0; // ! Null safety, porque la primera emision va a ser nula
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(value: progressValue, strokeWidth: 2, backgroundColor: Colors.black12),
              const SizedBox(width: 20),
              // ! LinearProgressIndicator() necesita SI o SI que se le delimite el ancho que va a ocupar
              Expanded( // Widget que permite tomar todo el espacio que el widget padre permita
                child: LinearProgressIndicator(value: progressValue,)
              )
            ],
          ),
        );
      })
    );
  }
}