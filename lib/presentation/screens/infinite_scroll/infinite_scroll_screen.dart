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
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;
  bool isMounted = true; // referido al widget _InfiniteScrollsScreenState

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      // scrollController.position.pixels; // posicion actual del scroll
      // scrollController.position.maxScrollExtent; // posicion maxima a la que puede llegar el scroll en la pantalla del movil
      // * Forma de determinar que estamos al final del scroll cuando el usuario desliza (el '500' es el umbral/threshold de margen que damos para que se ejecute esa nueva carga de imagenes)
      if((scrollController.position.pixels + 500) >= scrollController.position.maxScrollExtent){
        // Load next page
        loadNextPage();
      }
    });
  }

  @override
  void dispose() { // se llama cuando el widget va a ser destruido o ya no existe
    scrollController.dispose(); // ! Obligatorio en los Stateful widgets el ir liberando memoria y recursos según se dejan de usar
    isMounted = false;
    super.dispose();
  }

  Future loadNextPage() async { // * Para que haga el efecto de tiempo de carga de las imagenes (hasta que no se cargan 5 imagenes completamente, no empieces a cargar las otras 5)
    if(isLoading) return; // Si 'isLoading = true' ya estoy haciendo la peticion de carga, asi que no cargues mas imagenes
    isLoading = true; // Cuando empiece a cargar
    setState(() {}); // esto permite añadir/dibujar un loading o algo similar en la pantalla para indicar al usuario que se esta cargando
    await Future.delayed(const Duration(seconds: 2));

    addFiveImages();
    isLoading = false;

    // ! Revisar que no nos hemos salido del widget/pagina donde esta el listView mientras están cargarndo las imágenes, pues puede dar lugar a excepciones y errores.
    // ! Esto hay que hacerlo en TODOS los lugares donde la petición sea 'async'. En este caso, la llamada las imagenes https//...
    if(!isMounted) return; // salte de la carga de imagenes si el widget no esta montado, es decir, si el usuario ha empezado a cargar imagenes pero ha decidido salirse antes de que termine
    setState(() {}); // ! FUNCION QUE ACTUALIZA LOS (stateful) WIDGETS, QUE REENDERIZA LOS WIDGETS de nuevo
  }

  void addFiveImages() {
    final lastId = imagesIds.last;
    //-----------------------------------------------
    imagesIds.addAll(
      [1,2,3,4,5].map((e) => lastId + e)
    );
    // Forma equivalente pero menos sofisticada de ir aumentando la lista en una unidad cada vez, para tener 1,2,3,4,5,6,7,8,9,10,11...
    // imagesIds.add(lastId + 1);
    // imagesIds.add(lastId + 2);
    // imagesIds.add(lastId + 3);
    // imagesIds.add(lastId + 4);
    // imagesIds.add(lastId + 5);    
    //-----------------------------------------------    
  }

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
        controller: scrollController,
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