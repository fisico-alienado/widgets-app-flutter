import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_riverpod_app/config/theme/app_theme.dart';

// Estado => isDarkModeProvider = boolean
// * StateProvider almacena valores que se pueden leer y modificar desde fuera
final isDarkModeProvider = StateProvider((ref) => false);

// Int para manejar el indice del listado de colores
final selectedColorProvider = StateProvider((ref) => 0);

//---------------------------------------------------------------------------------------------------------------------

// Listado de colores inmutables
// * Provider almacena el valor de objetos inmutables
final colorListProvider = Provider((ref) => colorList);

// Un objeto de tipo AppTheme (custom)
//* StateNotifierProvider --> (primer argumento) una clase de tipo (o que derive de) StateNotifier<> controla el estado (segundo argumento) del objeto que le pasamos
final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier() // ! Podriamos pasarle ThemeNotifier(ref) para que ThemeNotifier tuviera toda la info de Riverpod, pero mejor no hacerlo
);
    // ThemeNotifier Function(StateNotifierProviderRef<ThemeNotifier, AppTheme>) _createFn --> una función de tipo
    // Function(StateNotifierProviderRef<ThemeNotifier, AppTheme>) que devuelve (=>) un ThemeNotifier

// Controller/Notifier
class ThemeNotifier extends StateNotifier<AppTheme> {

  //* Estamos obligados a crear un constructor que invoque/inicialice la clase padre de la que heredamos
  //* abstract class StateNotifier<T> --> An observable class that stores a single immutable [state].
  // State = Estado = new AppTheme(); --> Estamos creando una instancia de AppTheme
  ThemeNotifier(): super(AppTheme());

  void toggleDarkMode() {
    //? state.isDarkMode = false; No se puede cambiar directamente el estado de las propiedades de la clase AppTheme por ser tipo 'final'
    state = state.copyWith( isDarkMode: !state.isDarkMode );
  }

  void changeColorIndex(int colorIndex) {
    state = state.copyWith( selectedColor: colorIndex );
  }
}