import 'package:app_cripto/Repositories/foavoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Moedas/moeda.dart';
import '../resources/text_style.dart';
import '../widget/moeda_card.dart';

class FavoritasPage extends StatefulWidget {
  const FavoritasPage({super.key});

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  List<Moeda> favoritas = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 35, 29),
        title: const Text('Favoritas', style: CriptoTextStyle.titlePageDetail),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: Consumer<FavoritasRepository>(
            builder: (context, favoritas, child) {
              return favoritas.lista.isEmpty
                  ? const ListTile(
                      leading: Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      title: Text(
                        'Ainda não há moedas favoritas',
                        style: CriptoTextStyle.textfavorite,
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: (_, index) {
                        return MoedaCard(moeda: favoritas.lista[index]);
                      },
                      itemCount: favoritas.lista.length,
                    );
            },
          )),
    );
  }
}
