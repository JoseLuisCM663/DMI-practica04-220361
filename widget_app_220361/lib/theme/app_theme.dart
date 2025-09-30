import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.black,
  Colors.green,
  Colors.white,
  Colors.yellow,
  Colors.grey,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.red,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
    : assert(selectedColor >= 0, "La posicion del color debe ser mayor a 0"),
      assert(
        selectedColor < colorList.length,
        "La posicion del color no debe ser superior al tamaño de la lista",
      );
  ThemeData getTheme() =>
      ThemeData(useMaterial3: true, colorSchemeSeed: colorList[selectedColor]);
}
