import 'package:app_cripto/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyCriptoApp extends StatelessWidget {
  const MyCriptoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "MoedasBase",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
