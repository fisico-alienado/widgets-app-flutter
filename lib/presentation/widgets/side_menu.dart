import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_riverpod_app/config/menu/menu_items.dart';
import 'package:animate_do/animate_do.dart';

class SideMenu extends StatefulWidget {
  // ! Estamos utilizando los estados de los widgets como gestores de estado, por ello hay tanto stateful widget. Sino, podrían ser stateless
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDrawerIndex = 0; // * Saber que opcion del menu de navegacion ha sido seleccionado

  // ! Forma de determinar en que plataforma estamos: Linux, Windows, Android, IOs, etc
  final platform = Platform.isAndroid;
  final platform1 = Platform.isLinux;
  final platform2 = Platform.isIOS;

  @override
  Widget build(BuildContext context) {

    // ! Hay posiblemente paquetes de terceros para tratar con el notch, pero esta es una forma rapida de saber, utilizando un emulador con notch, cuanto mas o menos ocupa un notch
    // final hasNotch = MediaQuery.of(context).viewPadding.top; // Foorma rapida de ver el padding en el top en la consolo de debug
    // if (Platform.isAndroid){
    //   print('Android $hasNotch');
    // } else {
    //   print('IOS $hasNotch');
    // }

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;

    return FadeInLeft( // * Toque que le he dado yo
      duration: const Duration(milliseconds: 200),
      child: NavigationDrawer(
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) { // cada NavigationDrawerDestination tiene un identificador 'int'
          setState(() {
            navDrawerIndex = value;
          });
    
          final menuItem = appMenuItems[value]; // Como el menu lateral tiene el mismo orden que appMenuItems, sabemos el valor seleccionado
          // ? Go_router
          context.push(menuItem.link); // Para navigating to a route based on the URL, es decir, el path
        },
        children: [
          Padding( // Introducido para ver con lidiar con el tema del Notch o isla dinamica de algunos móviles
            padding: EdgeInsets.fromLTRB(28, hasNotch ? 5 : 20, 16, 10),
            child: const Text('Main')
          ),
    
          // ! En la REALIDAD la forma seria un NavigationDrawer.builder() o algo asi que fuese construyendo las opciones desde 'menu_items.dart' para que fuese más mantenible
          // * ... spread operator
          // ...appMenuItems.map((item) => NavigationDrawerDestination(
          //   icon: Icon(item.icon),
          //   label: Text(item.title)
          // ),),
    
          // ? Forma mas artistica de Fernando que la anterior
          ...appMenuItems
            .sublist(0,3) // mostrar solo los 3 primeros elementos del menuitems
            .map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title),
            ),
          ),
    
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
            child: Divider(),
          ),
    
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
            child: Text('More options')
          ),
    
          ...appMenuItems
            .sublist(3) // mostrar del 3er elemento del menuitems al final
            .map((item) => NavigationDrawerDestination(
              icon: Icon(item.icon),
              label: Text(item.title)
            ),
          ),
    
        ],
      ),
    );
  }
}