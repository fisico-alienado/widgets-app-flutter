import 'package:flutter/material.dart';

class UiControlsScreen extends StatelessWidget {

  static const name = 'ui_controls_screen';

  const UiControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Poniendo Scaffold ya estamos indicando que es otra pantalla
      appBar: AppBar(
        title: const Text('UI Controls'),
      ),
      body: const _UiControlsView(),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.arrow_back_ios_new_rounded),
      //   onPressed: () {

      //   },
      // ),
    );
  }
}

class _UiControlsView extends StatefulWidget {
  // ! Stateful en vez de Stateless porque asi tenemos un widget que puede mantener un estado (con estado nos referimos a las propiedades que queremos animar). 
  // ! Mejor solucion que utilizar un gestor de estado para esta funcionalidad, que sería otra opción  
  const _UiControlsView();

  @override
  State<_UiControlsView> createState() => _UiControlsViewState();
}

enum Transportation {car, plane, boat, submarine}
class _UiControlsViewState extends State<_UiControlsView> {

  bool isDeveloper = true;
  Transportation selectedTransportation = Transportation.car;
  bool wantsBreakfast = false;
  bool wantsLunch = false;
  bool wantsDinner = false;

  String showTransportation(){ // * Mi personalización
    final String transportation;
    if(selectedTransportation == Transportation.car){
      transportation = 'Coche';
    }
    else if(selectedTransportation == Transportation.plane){
      transportation = 'Avión';
    }
    else if(selectedTransportation == Transportation.boat){
      transportation = 'Barco';
    }
    else{
      transportation = 'Submarino';
    }
    return transportation;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const ClampingScrollPhysics(), // evita el efecto de rebote de la lista
      children: [
        SwitchListTile( // si termina en 'Tile' es 'widget que le aplica estilo a')
          value: isDeveloper,
          title: const Text('Developer Mode'),
          subtitle: const Text('Controles adicionales'),
          onChanged: (value) {
            setState(() { // ! FUNCION QUE ACTUALIZA LOS (stateful) WIDGETS, QUE REENDERIZA LOS WIDGETS de nuevo
              isDeveloper = !isDeveloper;
            });
          }
        ),

        Switch(
          value: isDeveloper, 
          onChanged: (value) => setState(() {
            isDeveloper = !isDeveloper;
          })
        ),

        ExpansionTile(
          title: const Text('Vehículo de transporte'),
          subtitle: Text(showTransportation()), // * Mi personalizacion
          // subtitle: Text('$selectedTransportation'),
          children: [
            RadioListTile(
              title: const Text('By Car'),
              subtitle: const Text('Viajar en coche'),
              value: Transportation.car, 
              groupValue: selectedTransportation, 
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.car;
              })
            ),
            
            RadioListTile(
              title: const Text('By Plane'),
              subtitle: const Text('Viajar en avión'),          
              value: Transportation.plane, 
              groupValue: selectedTransportation, 
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.plane;
              })
            ),

            RadioListTile(
              title: const Text('By Boat'),
              subtitle: const Text('Viajar en barco'),          
              value: Transportation.boat, 
              groupValue: selectedTransportation, 
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.boat;
              })
            ),

            RadioListTile(
              title: const Text('By Submarine'),
              subtitle: const Text('Viajar en submarino'),          
              value: Transportation.submarine, 
              groupValue: selectedTransportation, 
              onChanged: (value) => setState(() {
                selectedTransportation = Transportation.submarine;
              })
            ),
          ],
        ),

        ExpansionTile(
          title: const Text('Régimen de comidas'),
          children: [
            CheckboxListTile(
              title: const Text('¿Incluir desayuno?'),
              value: wantsBreakfast, 
              onChanged: (value) => setState(() {
                wantsBreakfast = !wantsBreakfast;
              })
            ),
            CheckboxListTile(
              title: const Text('¿Incluir comida?'),
              value: wantsLunch, 
              onChanged: (value) => setState(() {
                wantsLunch = !wantsLunch;
              })
            ),
            CheckboxListTile(
              title: const Text('¿Incluir cena?'),
              value: wantsDinner, 
              onChanged: (value) => setState(() {
                wantsDinner = !wantsDinner;
              })
            ),            
          ],
        ),
      ],
    );
  }
}