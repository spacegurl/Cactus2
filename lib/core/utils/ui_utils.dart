import 'package:flutter/material.dart';

//Утилиты для интерфейса
class UiUtils {
  //Отображение snackbar
  static void showSnackBar(
    BuildContext context,
    String title, {
    Color color = Colors.green,
    int milliseconds = 4000,
    SnackBarBehavior? behavior,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      getSnackBar(title, color, milliseconds, behavior),
    );
  }

  //Создание snackbar
  static SnackBar getSnackBar(
    String title, [
    Color? color,
    int milliseconds = 4000,
    SnackBarBehavior? behavior,
  ]) {
    return SnackBar(
      content: Text(title),
      duration: Duration(milliseconds: milliseconds),
      backgroundColor: color,
      behavior: behavior,
    );
  }
}
