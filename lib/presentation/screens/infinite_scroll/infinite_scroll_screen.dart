import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InfiniteScrollScreen extends StatefulWidget {
  // ! Stateful en vez de Stateless porque asi tenemos un widget que puede mantener un estado (con estado nos referimos a las propiedades que queremos animar). 
  // ! Mejor solucion que utilizar un GESTOR DE ESTADOS para esta funcionalidad, que sería otra opción
  static const name = 'infinite_screen';

  const InfiniteScrollScreen({super.key});

  @override
  State<InfiniteScrollScreen> createState() => _InfiniteScrollScreenState();
}

class _InfiniteScrollScreenState extends State<InfiniteScrollScreen> {

  List<int> imagesIds = [1,2,3,4,5];

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      // appBar: AppBar(
      //   title: const Text('Infinite scroll'),
      // ),
      backgroundColor: Colors.black,
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true, // poner a false cuando quiera recordar que hacia esto, pero quita el trozo de isla dinamica donde pone la hora, la bateria, etc
        removeBottom: true,
        child: ListView.builder( // ! La idea del .builder() es que el listado se construya bajo demanda y NO SE ALMACENE EN LA MEMORIA
          // Si no se define "itemCount", es una lista infinita per se.
          itemCount: imagesIds.length,
          itemBuilder: (context, index) { // el 'index' hace referencia al 'itemCount'
            return FadeInImage( // * Superutil porque nos permite mostrar un placeholder (una imagen, icono, gif etc) mientras se va cargando la imagen principal
              fit: BoxFit.cover, // fit: como queremos que la imagen se adapte a su espacio
              width: double.infinity,
              height: 300,
              placeholder: const AssetImage("assets/images/jar-loading.gif"),
              image: NetworkImage(
                'https://picsum.photos/id/${ imagesIds[index] }/500/300'
              )
            );
          },
        ),
      ),
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