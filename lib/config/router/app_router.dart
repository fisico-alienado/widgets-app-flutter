import 'package:go_router/go_router.dart';
import 'package:widgets_riverpod_app/presentation/screens/screens.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/', // ! Pantalla que se va a ver por defecto. Esta interesante para TESTEAR porque podemos poner de principal screens que queramos testear
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/buttons',
      builder: (context, state) => const ButtonsScreen(),
    ),

    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardsScreen(),
    ),
  ],
);