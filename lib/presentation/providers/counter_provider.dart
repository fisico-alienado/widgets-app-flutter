import 'package:flutter_riverpod/flutter_riverpod.dart';

// ! Cuando se trabajo con Riverpod se termina trabajando con muchos (pequeños) providers que hacen que sea facil de mantener y testear cada funcionalidad

final counterProvider = StateProvider((ref) => 0); // * Es como el 'state' de un StatefulWidget, es decir, provee de estado. El 0 es el valor que he decidido ponerle de inicio