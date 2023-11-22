import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgets_riverpod_app/config/theme/app_theme.dart';

// Estado => isDarkModeProvider = boolean
final isDarkModeProvider = StateProvider((ref) => false);

// Listado de colores inmutables
final colorListProvider = Provider((ref) => colorList);

// Int para manejar el indice del listado de colores
final selectedColorProvider = StateProvider((ref) => 0);