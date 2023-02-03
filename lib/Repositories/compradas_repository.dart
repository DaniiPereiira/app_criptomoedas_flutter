import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../Moedas/moeda.dart';

class CompradasRepository extends ChangeNotifier {
  final List<Moeda> _compra = [];
  UnmodifiableListView<Moeda> get compra => UnmodifiableListView(_compra);

  saveAll(List<Moeda> moedasCompradas) {
    for (var moeda in moedasCompradas) {
      if (!_compra.contains(moeda)) _compra.add(moeda);
    }
    notifyListeners();
  }

  remove(Moeda moeda) {
    _compra.remove(moeda);
    notifyListeners();
  }
}

class SaldoComprada extends ChangeNotifier {

  List lista = [];
double valor = 0;



}
