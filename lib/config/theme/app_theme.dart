import 'package:flutter/material.dart';

const Color _customColor = Color.fromARGB(255, 29, 137, 225);

const List<Color> colorList = [
  _customColor,
  Color(0xFF49149F),  
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
  Colors.pink,
  Colors.red
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  }) : assert( selectedColor >= 0 && selectedColor <= colorList.length - 1, 
              'Color must be between 0 and ${colorList.length}');

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true, 
      colorSchemeSeed: colorList[selectedColor],
      appBarTheme: const AppBarTheme(
        centerTitle: false
      ),
      brightness: isDarkMode ? Brightness.dark : Brightness.light
    );
  }
}