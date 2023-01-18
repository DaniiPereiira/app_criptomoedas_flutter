import 'package:app_cripto/pages/moedas_page.dart';
import 'package:flutter/material.dart';

import 'favoritas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc;

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pc,
        children: const [
          MoedasPage(),
          FavoritasPage(),
        ],
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        backgroundColor: Color.fromARGB(255, 58, 70, 58),
        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            icon: Icon(
              Icons.list,
            ),
            label: 'Todas',
          ),
          const BottomNavigationBarItem(
            backgroundColor: Color.fromARGB(255, 255, 255, 255),
            icon: Icon(Icons.favorite),
            label: 'Favorits',
          ),
        ],

        onTap: (pagina) {
          pc.animateToPage(pagina,
              duration: const Duration(microseconds: 400), curve: Curves.ease);
        },
      ),
    );
  }
}