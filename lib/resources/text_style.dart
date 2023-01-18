import 'package:flutter/material.dart';

abstract class CriptoTextStyle {
  static const titlePageCripto = TextStyle(
    fontFamily: "Urw",
    fontSize: 30.0,
    color: Color.fromARGB(255, 124, 124, 124),
  );

  static const titlePageDetail = TextStyle(
    fontFamily: "Urw",
    fontSize: 25.0,
    color: Color.fromARGB(255, 124, 124, 124),
  );

  static const fontMoeda = TextStyle(
      fontSize: 18.0,
      color: Color.fromARGB(255, 255, 255, 255),
      letterSpacing: 2,
      fontWeight: FontWeight.bold);

  static const fontSigla = TextStyle(
      fontSize: 12.0,
      color: Color.fromARGB(255, 215, 213, 213),
      fontWeight: FontWeight.w400);

  static const fontPreco = TextStyle(
      fontSize: 15.0,
      color: Color.fromARGB(255, 215, 213, 213),
      fontWeight: FontWeight.w300);

  static const fontMoedaDetail = TextStyle(
      fontSize: 26.0,
      color: Color.fromARGB(255, 248, 251, 247),
      fontWeight: FontWeight.w600);

  static const valorMoedaDetail = TextStyle(
      fontSize: 20,
      color: Color.fromARGB(255, 253, 254, 253),
      fontWeight: FontWeight.bold);

  static const valorNomeDetail = TextStyle(
    color: Color.fromARGB(255, 246, 248, 245),
  );

  static const quantidadeDetail = TextStyle(
    fontSize: 20,
    color: Color.fromARGB(255, 242, 247, 240),
    fontWeight: FontWeight.bold,
  );

  static const comprarDetail = TextStyle(
    fontSize: 15,
    color: Color.fromARGB(255, 246, 248, 245),
  );

  static const textfavorite = TextStyle(
    fontSize: 20,
    color: Color.fromARGB(255, 242, 247, 240),
  );
}
