import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String caption;
  final String imageUrl;

  SlideInfo({
    required this.title, 
    required this.caption, 
    required this.imageUrl
  });
}

final slides = <SlideInfo>[ // ! Es como menu_items.dart
  SlideInfo(
    title: 'Busca la comida', 
    caption: 'Dolor proident magna Lorem reprehenderit. Officia enim ut incididunt laborum aute incididunt minim exercitation reprehenderit eu enim esse officia. Culpa exercitation est proident ea ex enim ea id nulla eu adipisicing amet cillum. Exercitation laborum ea qui occaecat sunt non consequat. Fugiat aute ipsum labore anim reprehenderit. Nostrud consectetur voluptate Lorem magna consectetur labore laborum dolor tempor dolor reprehenderit..', 
    imageUrl: 'assets/images/1.png'
  ),
  SlideInfo(
    title: 'Entrega rápida', 
    caption: 'Deserunt incididunt laboris fugiat ad mollit cillum eu enim ullamco excepteur ipsum anim reprehenderit velit. Dolor consequat sint enim sint tempor quis officia mollit eiusmod reprehenderit aliqua ex consectetur laboris. Tempor magna proident incididunt mollit laboris ut.', 
    imageUrl: 'assets/images/2.png'
  ),
  SlideInfo(
    title: 'Disfruta la comida', 
    caption: 'Aliquip sint incididunt qui qui culpa exercitation quis. Amet ea aliquip consectetur Lorem non anim aliqua qui eu adipisicing excepteur eiusmod duis sint. Cillum duis elit nostrud do ut consequat Lorem elit eu aliquip eu labore sunt. Laborum duis proident officia consectetur amet non elit nulla elit consequat. Fugiat aliqua irure et sint elit esse. Dolor non sunt culpa ea labore aliquip commodo enim laboris qui esse ea.', 
    imageUrl: 'assets/images/3.png'
  ),

];

class AppTutorialScreen extends StatefulWidget {

  static const name = 'tutorial_screen';
  // ! Stateful en vez de Stateless porque asi tenemos un widget que puede mantener un estado (con estado nos referimos a las propiedades que queremos animar). 
  // ! Mejor solucion que utilizar un gestor de estado para esta funcionalidad, que sería otra opción  
  const AppTutorialScreen({super.key});

  @override
  State<AppTutorialScreen> createState() => _AppTutorialScreenState();
}

class _AppTutorialScreenState extends State<AppTutorialScreen> {

  final PageController pageviewController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();
    pageviewController.addListener(() {
      // print('${pageviewController.page}'); // solo para debuggear y ver como las paginas cargan de la 0.0 a la 2.0 y los valores que toma en las transiciones
      final page = pageviewController.page ?? 0; // ! null safety
      if(!endReached && page >= (slides.length - 1.5)){ // -1.5 por que hay tres imagenes, entonces con 1.5 decimos que cuando el usuario deslice hasta la mitad de la tercera imagen (3 - 1.5 = 1.5), se cambie el estado de una variable
        setState(() { // ! FUNCION QUE ACTUALIZA LOS (stateful) WIDGETS, QUE REENDERIZA LOS WIDGETS de nuevo
          endReached = true; // * OJO ya se queda con valor true permanentemente hasta que salgamos el widget del tutorial
        });
      }
    });
  }

  @override
  void dispose() {
    pageviewController.dispose(); // ! Obligatorio en los Stateful widgets el ir liberando memoria y recursos según se dejan de usar
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // ! Lo ideal seria eliminar los Stateful Widgets y convertirlos a Riverpod ConsumerWidgets, pero aprovecho que estan como stateful para hacer el cambio de Brigthness con esta configuracion
    final colors = Theme.of(context).colorScheme; // Esto significa: vete para atras en los widgets padres hasta que encuentres el Theme y aplicalo. Para esto esta el argumento "BuildContext context" en todos los Widgets
                                                  // con .colorScheme accedemos a todo lo definido en AppTheme()

    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      backgroundColor: colors.brightness == Brightness.light ? Colors.white : colors.background, // porque el fondo de las imagenes es blanco
      body: Stack(
        children: [
          PageView(
            controller: pageviewController,
            physics: const BouncingScrollPhysics(),
            children: [ // ! Parecido a 'cards_screen.dart'
              ...slides.map( // ! con ... podemos hacer un spread dentro del widget, que nos permite devolver elementos iterables en el orden en el que están definidos
                (slideData) => _Slide(
                  title: slideData.title, 
                  caption: slideData.caption, 
                  imageUrl: slideData.imageUrl
                )
              )
            ],
            // ? Otra forma valida
          //   children: slides.map(
          //       (slideData) => _Slide(
          //         title: slideData.title, 
          //         caption: slideData.caption, 
          //         imageUrl: slideData.imageUrl
          //       )
          //     ).toList()

          ),

          // * Condicion ternaria para mostrarlo o no
          endReached ? 
          const SizedBox() // ! SizeBox() es lo que se suele poner cuando no podemos devolver un 'null' y hay que devolver un widget vacio que no haga nada
          : Positioned(
            right: 20,
            top: 50,
            child: ElevatedButton(
              child: const Text('Salir'), 
              onPressed: () => context.pop()
            ),
          ),

          endReached ? Positioned(
            bottom: 30,
            right: 30,
            child: FadeInRight(
              from: 30,
              delay: const Duration(seconds: 1),
              child: FilledButton(
                child: const Text('Fin del tutorial'), 
                onPressed: () => context.pop()
              ),
            )
          ) : const SizedBox(),

        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget { // ! Se esta haciendo de esta manera para poder reutilizar esto en otras aplicaciones

  final String title;
  final String caption;
  final String imageUrl;

  const _Slide({
    required this.title,
    required this.caption, 
    required this.imageUrl
  });

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final captionStyle = Theme.of(context).textTheme.bodySmall;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // posicion de los children en la vertical
          crossAxisAlignment: CrossAxisAlignment.start, // posicion de los children en la horizontal
          children: [
            Image.asset(imageUrl),
            // Image(image: AssetImage(imageUrl)), // * Otra forma valida
            const SizedBox(height: 20,),
            Text(title, style: titleStyle,),
            const SizedBox(height: 20,),
            Text(caption, style: captionStyle,),

          ],
        ),
      ),
    );
  }
}