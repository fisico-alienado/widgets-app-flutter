import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  // ! Estamos utilizando los estados de los widgets como gestores de estado, por ello hay tanto stateful widget. Sino, podrían ser stateless
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0; // * Saber que opcion del menu de navegacion ha sido seleccionado

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) { // cada NavigationDrawerDestination tiene un identificador 'int'
        setState(() {
          navDrawerIndex = value;
        });
      },
      children: [
        NavigationDrawerDestination(
          icon: const Icon(Icons.add), 
          label: const Text('Home Screen')
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.add_shopping_cart_rounded), 
          label: const Text('Otra pantalla')
        ),
      ],
    );
  }
}