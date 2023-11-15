import 'package:flutter/material.dart';

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
    caption: 'Incididunt id ea irure occaecat eu.', 
    imageUrl: 'assets/images/1.png'
  ),
  SlideInfo(
    title: 'Entrega rápida', 
    caption: 'Labore voluptate incididunt enim occaecat.', 
    imageUrl: 'assets/images/2.png'
  ),
  SlideInfo(
    title: 'Disfruta la comida', 
    caption: 'Excepteur est ut excepteur excepteur.', 
    imageUrl: 'assets/images/3.png'
  ),

];

class AppTutorialScreen extends StatelessWidget {

  static const name = 'tutorial_screen';

  const AppTutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      body: PageView(
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          children: [
            Image.asset(imageUrl)
          ],
        ),
      ),
    );
  }
}