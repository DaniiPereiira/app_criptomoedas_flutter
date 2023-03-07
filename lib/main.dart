import 'package:app_cripto/Repositories/foavoritas_repository.dart';

import 'package:app_cripto/my_cripto_app.dart';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

import 'Repositories/compradas_repository.dart';
import 'Repositories/conta_repository.dart';

import 'configs/app_settings.dart';
import 'configs/hive_config.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveConfig.start();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ContaRepository()),
      ChangeNotifierProvider(create: (context) => AppSettings()),
      ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ChangeNotifierProvider(create: (context) => CompradasRepository()),
      ChangeNotifierProvider(create: (context) => SaldoComprada())
    ],
    child: const MyCriptoApp(),
  ));
}
