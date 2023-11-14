import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  void openDialog( BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // si esta false indica que aunque toques fuera del dialogo no se va a salir de él
      builder: (context) => AlertDialog(
        title: const Text('Diálogo personalizado'),
        content: const Text('Lorem nostrud dolor ad qui. Voluptate commodo eu ipsum ex esse duis proident voluptate culpa. Culpa amet amet in consectetur proident eu ipsum cupidatat do tempor ipsum do aliqua amet. Ut duis Lorem cillum velit do pariatur eu dolor excepteur irure sint.'),
        actions: [
          TextButton(onPressed: () => context.pop(), child: const Text('Cancelar')),
          FilledButton(onPressed: () => context.pop(), child: const Text('Aceptar')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('Snackbars y Diálogos'),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            FilledButton.tonal( // * Dialogo prefabricado
              onPressed: (){
                showAboutDialog( // ! Método integrado en flutter que muestra las licencias y paquetes usados en la app
                  context: context,
                  children: [
                    const Text('Sint nostrud commodo dolore deserunt excepteur adipisicing ullamco ad. Enim sunt ad ut occaecat laborum dolore irure nisi irure nulla cillum aliqua. Lorem nisi cillum proident eu aliquip velit Lorem amet fugiat minim. Voluptate est reprehenderit commodo aliquip id eiusmod in sint velit amet est elit. Irure Lorem minim labore ex velit irure proident proident qui. Laboris deserunt consectetur nulla mollit sint ut anim cupidatat id commodo ullamco minim pariatur. Officia cupidatat exercitation incididunt sunt tempor aliqua et fugiat voluptate fugiat consequat.')
                  ]
                );
              }, 
              child: const Text('Licencias usadas')
            ),

            FilledButton.tonal( // * Diálogo personalizado
              onPressed: (){
                openDialog(context);
              }, 
              child: const Text('Mostrar diálogo')
            ),
          ],
        ),
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