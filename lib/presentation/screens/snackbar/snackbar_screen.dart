import 'package:flutter/material.dart';

class SnackbarScreen extends StatelessWidget {

  static const name = 'snackbar_screen';

  const SnackbarScreen({super.key});

  void showCustomSnackbar( BuildContext context){

    ScaffoldMessenger.of(context).clearSnackBars(); // ! Clave para que aunque toquemos el boton de snackbar muchas veces no se vuelva loco y borre el anterior snackbar

    final snackBar = SnackBar(
      content: const Text('Hola Mundo'),
      action: SnackBarAction(label: 'Pulsa para cerrarme', onPressed: (){}),
      duration: const Duration(seconds: 3), // tiempo que se muestra el snackbar
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Mostrar Snackbar'),
        icon: const Icon(Icons.remove_red_eye_outlined),
        onPressed: () {        
          showCustomSnackbar(context);
        },
      ),
    );
  }
}