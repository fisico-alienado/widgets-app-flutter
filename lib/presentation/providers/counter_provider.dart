import 'package:flutter_riverpod/flutter_riverpod.dart';

// ! Cuando se trabajo con Riverpod se termina trabajando con muchos (pequeños) providers que hacen que sea facil de mantener y testear cada funcionalidad

final counterProvider = StateProvider((ref) => 5); // * Es como el 'state' de un StatefulWidget, es decir, provee de estado