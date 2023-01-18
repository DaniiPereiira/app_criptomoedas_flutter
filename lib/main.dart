
import 'package:app_cripto/Repositories/foavoritas_repository.dart';
import 'package:app_cripto/my_cripto_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => FavoritasRepository(),
    child: const MyCriptoApp(),
  ));
}