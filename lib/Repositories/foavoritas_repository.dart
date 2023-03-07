// ignore_for_file: depend_on_referenced_packages

import 'dart:collection';
import 'package:flutter/cupertino.dart';
import '../Moedas/moeda.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../adapters/moeda_hive_adapter.dart';

class FavoritasRepository extends ChangeNotifier {
  final List<Moeda> _lista = [];
  late LazyBox box;

  FavoritasRepository() {
    _startRepository();
  }

  _startRepository() async {
    await _openBox();
    await _readFavoritas();
  }

  _openBox() async {
    Hive.registerAdapter(MoedaHiveAdapter());
    box = await Hive.openLazyBox<Moeda>('moedas_favoritas');
  }

  _readFavoritas() {
    box.keys.forEach((moeda) async {
      Moeda m = await box.get(moeda);
      lista.add(m);
      notifyListeners();
    });
  }

  // ignore: non_constant_identifier_names
  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);

  saveAll(List<Moeda> moedas) {
    for (var moeda in moedas) {
      if (!_lista.any((atual) => atual.sigla == moeda.sigla)) {
        _lista.add(moeda);
        box.put(moeda.sigla, moeda);
      }
    }
    notifyListeners();
  }

  remove(Moeda moeda) {
    _lista.remove(moeda);
    box.delete(moeda.sigla);
    notifyListeners();
  }
}
