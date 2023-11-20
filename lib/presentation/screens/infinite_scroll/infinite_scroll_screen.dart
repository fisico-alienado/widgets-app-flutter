import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

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
  bool isMounted = true; // referido, por supuesto, al widget _InfiniteScrollsScreenState

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
    // ! Revisar que no nos hemos salido del widget/pagina donde esta el listView mientras están cargarndo las imágenes, pues puede dar lugar a excepciones y errores.
    // ! Esto hay que hacerlo en TODOS los lugares donde la petición sea 'async'. En este caso, la llamada las imagenes https//...
    if(!isMounted) return; // salte de la carga de imagenes si el widget no esta montado, es decir, si el usuario ha empezado a cargar imagenes pero ha decidido salirse antes de que termine
    if(isLoading) return; // Si 'isLoading = true' ya estoy haciendo la peticion de carga, asi que no cargues mas imagenes
    isLoading = true; // Cuando empiece a cargar
    setState(() {}); // esto permite añadir/dibujar un loading o algo similar en la pantalla para indicar al usuario que se esta cargando
    await Future.delayed(const Duration(seconds: 2));

    // addFiveImages();
    // setState(() {}); // ! FUNCION QUE ACTUALIZA LOS (stateful) WIDGETS, QUE REENDERIZA LOS WIDGETS de nuevo
    addFiveImagesAsync();
    isLoading = false; // * devolverlo a false para la siguiente carga

    // todo: mover el scroll
  }

  Future<int> checkImageExists(String imageUrl, int imageID) async {
    // * La pagina "picsum" le faltan algunos ids que hacen que la aplicacion falle al no encontrar la url y he ideado esto como proteccion
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode != 200) {
      imageID++;
      checkImageExists(imageUrl, imageID); // ! He creado mi propia función recursiva para chequear que la imagen existe
    }

    return imageID;
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

  Future<void> addFiveImagesAsync() async {
    final lastId = imagesIds.last;
    for (int i = 1; i <= 5; i++) {
      int nextId = lastId + i;
      String imageUrl = 'https://picsum.photos/id/$nextId/500/300';
      nextId = await checkImageExists(imageUrl, nextId);
      imagesIds.add(nextId);
    }
    setState(() {}); // ! FUNCION QUE ACTUALIZA LOS (stateful) WIDGETS, QUE REENDERIZA LOS WIDGETS de nuevo
  }

  Future<void> onRefresh() async {    
    isLoading = true; // * Cuando empiece a cargar
    setState(() {}); // esto permite añadir/dibujar un loading o algo similar en la pantalla para indicar al usuario que se esta cargando
    await Future.delayed(const Duration(seconds: 3));
    if(!isMounted) return; // salte de la carga de imagenes si el widget no esta montado, es decir, si el usuario ha empezado a cargar imagenes pero ha decidido salirse antes de que termine
    // ? Esto podría tunearse como se quisiera, Fernando decidio esta
    final lastId = imagesIds.last;    
    imagesIds.clear();
    imagesIds.add(lastId + 1);
    // addFiveImages();
    addFiveImagesAsync();
    isLoading = false; // * devolverlo a false para la siguiente carga
    setState(() {}); // ! FUNCION QUE ACTUALIZA LOS (stateful) WIDGETS, QUE REENDERIZA LOS WIDGETS de nuevo  
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
        child: RefreshIndicator(
          onRefresh: () => onRefresh(),
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
                image: NetworkImage('https://picsum.photos/id/${ imagesIds[index] }/500/300')           
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: isLoading ?
               const CircularProgressIndicator()
               : FadeIn(child: const Icon(Icons.arrow_back_ios_new_rounded)),
        // ? Otra forma con el paquete de Fernando Herrera
        // child: isLoading ?
        //        SpinPerfect(                  
        //           infinite: true,
        //           child: const Icon(Icons.refresh_rounded),
        //         )
        //        : FadeIn(child: const Icon(Icons.arrow_back_ios_new_rounded)),
        onPressed: () {
          if(!isLoading){ // toque personal: que el usuario no pueda salirse mientras se cargan imagenes
            context.pop(); // ! Para volver a la pantalla anterior. Esta es la forma de hacerlo con Go Router
            // Navigator.of(context).pop(...) // * Si usamos 'Navigator'
          }
        },
      ),
    );
  }
}