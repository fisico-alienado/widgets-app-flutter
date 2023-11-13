import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const List<Map<String, dynamic>> cards = <Map<String, dynamic>>[ // ! No hace falta indicar el tipo de dato, pero yo lo hago con fines de aprendizaje 
  {'elevation': 0.0, 'label': ' Elevation 0'},
  {'elevation': 1.0, 'label': ' Elevation 1'},
  {'elevation': 2.0, 'label': ' Elevation 2'},
  {'elevation': 3.0, 'label': ' Elevation 3'},
  {'elevation': 4.0, 'label': ' Elevation 4'},
  {'elevation': 5.0, 'label': ' Elevation 5'},
];
class CardsScreen extends StatelessWidget {

  static const String name = 'cards_screen';

  const CardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('Cards Screen'),
      ),
      body: const _CardsView(),
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

class _CardsView extends StatelessWidget {
  
  const _CardsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // ! Para evitar errores de overflow de contenido y permitir hacer scroll del contenido
      child: Column(
        children: [
          ...cards.map( // ! con ... podemos hacer un spread dentro del widget, que nos permite devolver elementos iterables en el orden en el que están definidos
            (card) => _CardType1(elevation: card['elevation'], label: card['label'])
          ),
          const SizedBox(height: 50), // para dejar espacio
          ...cards.map(
            (card) => _CardType2(elevation: card['elevation'], label: card['label'])
          ),
          const SizedBox(height: 50), // para dejar espacio
          ...cards.map(
            (card) => _CardType3(elevation: card['elevation'], label: card['label'])
          ),
          const SizedBox(height: 50), // para dejar espacio
          ...cards.map(
            (card) => _CardType4(elevation: card['elevation'], label: card['label'])
          ),

          const SizedBox(height: 100) // para dejar espacio y que no este pegado al final de la pantalla
        ],
      ),
    );
  }
}

class _CardType1 extends StatelessWidget {

  final String label;
  final double elevation;

  const _CardType1({
    required this.label, 
    required this.elevation
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation, // hace que podamos ver el color de la tarjeta (cuanto mayor el valor mas se ve el color)
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: (){},
              )
            ),

            Align(
              alignment: Alignment.bottomLeft,
              
              child: Text(label),
            )
          ]),
      ),
    );
  }
}

class _CardType2 extends StatelessWidget {

  final String label;
  final double elevation;

  const _CardType2({
    required this.label, 
    required this.elevation
    });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        side: BorderSide(
          color: colors.primary,
        )
      ),
      elevation: elevation, // hace que podamos ver el color de la tarjeta (cuanto mayor el valor mas se ve el color)
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: (){},
              )
            ),

            Align(
              alignment: Alignment.bottomLeft,
              
              child: Text('$label - outlined'),
            )
          ]),
      ),
    );
  }
}

class _CardType3 extends StatelessWidget {

  final String label;
  final double elevation;

  const _CardType3({
    required this.label, 
    required this.elevation
    });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return Card(
      color: colors.surfaceVariant,
      elevation: elevation, // hace que podamos ver el color de la tarjeta (cuanto mayor el valor mas se ve el color)
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: (){},
              )
            ),

            Align(
              alignment: Alignment.bottomLeft,
              
              child: Text('$label - filled'),
            )
          ]),
      ),
    );
  }
}

class _CardType4 extends StatelessWidget {

  final String label;
  final double elevation;

  const _CardType4({
    required this.label, 
    required this.elevation
    });

  @override
  Widget build(BuildContext context) {

    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: elevation, // hace que podamos ver el color de la tarjeta (cuanto mayor el valor mas se ve el color)
      child: Stack(
        children: [

          Image.network(
            'https://picsum.photos/id/${ elevation.toInt() }/600/500',
            height: 350,
            fit: BoxFit.cover, // fit: como queremos que la imagen se adapte a su espacio
          ),

          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20))
              ),
              child: IconButton(
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: (){},
              ),
            )
          ),
        ]),
    );
  }
}