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

class AppTutorialScreen extends StatelessWidget {

  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
    backgroundColor: Colors.white, // porque el fondo de las imagenes es blanco
      body: Stack(
        children: [
          PageView(
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

          Positioned(
            right: 20,
            top: 50,
            child: ElevatedButton(
              child: const Text('Salir'), 
              onPressed: () => context.pop()
            )
          )
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