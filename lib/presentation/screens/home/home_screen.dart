import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets_riverpod_app/config/menu/menu_items.dart';
import 'package:widgets_riverpod_app/presentation/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {

  static const String name = 'home_screen'; // ! Usado para poder recordar el nombre de la ruta del widget sin tener que irnos al app_router.dart

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Material 3'),
        // centerTitle: true, // mejor controlarlo desde el appTheme
      ),
      body: const _HomeView(),
      drawer: const SideMenu()
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(  // 'build' indica que algo se va a construir en tiempo de ejecucion de ese widget
      itemCount: appMenuItems.length,
      itemBuilder: (context, index){
        final menuItem = appMenuItems[index];
        return _CustomListTile(menuItem: menuItem);
      }
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.menuItem,
  });

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme; // Esto significa: vete para atras en los widgets padres hasta que encuentres el Theme y aplicalo. Para esto esta el argumento "BuildContext context" en todos los Widgets
                                                  // con .colorScheme accedemos a todo lo definido en AppTheme()

    return ListTile( // Widget estilizado especialmente usado con listas (si termina en 'Tile' es 'widget que le aplica estilo a')
      leading: Icon(menuItem.icon, color: colors.primary,),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      onTap: (){
        // * Si usamos 'Navigator'
        // ? Forma valida pero mejor con rutas
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => const ButtonsScreen()
        //   )
        // );
        // ? la mejor forma
        // Navigator.pushNamed(context, menuItem.link);

        // ? Go_router
        // context.go(menuItem.link); //* Para app webs mejor esto
        // context.pushNamed(ButtonsScreen.name); context.pushNamed(menuItem.name); // Para navegar con nombre de rutas, tendriamos que añadir al menu items el 'name' de la ruta como opcion
        context.push(menuItem.link); // Para navigating to a route based on the URL, es decir, el path
      },
    );
  }
}