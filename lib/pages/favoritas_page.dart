// ignore_for_file: depend_on_referenced_packages

import 'package:app_cripto/Repositories/foavoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Moedas/moeda.dart';
import '../Repositories/moeda_repositories.dart';
import '../configs/app_settings.dart';
import '../resources/text_style.dart';
import '../widget/moeda_card.dart';
import 'package:intl/intl.dart';


class FavoritasPage extends StatefulWidget {
  const FavoritasPage({super.key});

  @override
  State<FavoritasPage> createState() => _FavoritasPageState();
}

class _FavoritasPageState extends State<FavoritasPage> {
  late FavoritasRepository favoritas;
  List<Moeda> selecionadas = [];
  final tabela = MoedaRepository.tabela;
   late NumberFormat real;
   late Map<String, String> loc;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
     
      icon: const Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
                leading: const Icon(Icons.swap_vert),
                title: Text("Usar $locale"),
                onTap: () {
                  context.read<AppSettings>().setLocale(locale, name);
                  Navigator.pop(context);
                }))
      ],
    );
  }
  
  

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        actions: [
          changeLanguageButton(),
          IconButton(
            
            onPressed: () {
              //  showSearch(context: context, delegate: );
            },
            icon: const Icon(Icons.search),
          ),
          
        ],
        backgroundColor: const Color.fromARGB(255, 26, 35, 29),
        title: const Text(
          "Favoritas",
          style: CriptoTextStyle.titlePageCripto,
        ),
      );
    } else {
      return AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 35, 29),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: PopupMenuButton(
                icon: const Icon(Icons.more_vert),
                itemBuilder: (context) => [
                     
                      PopupMenuItem(
                          child: TextButton(
                        child: const Text(""),
                        onPressed: () {
                         

                          Navigator.pop(context);
                        },
                      )),
                    ]),
          )
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (() {
            setState(() {
              selecionadas = [];
            });
          }),
        ),
        title: Text("${selecionadas.length} selecionadas"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarDinamica(),
      body: Container(
          alignment: Alignment.topCenter,
          child: Consumer<FavoritasRepository>(
            builder: (context, favoritas, child) {
              return (favoritas.lista.isEmpty)
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
                      padding: const EdgeInsets.all(16),
                      itemCount: favoritas.lista.length,
                      itemBuilder: (_, index) {
                        return MoedaCard(
                          moeda: favoritas.lista[index],
                        );
                      },
                    );
            },
          )),
    );
  }
}
