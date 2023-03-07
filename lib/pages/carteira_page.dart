import 'package:app_cripto/Repositories/foavoritas_repository.dart';
import 'package:app_cripto/Repositories/moeda_repositories.dart';
import 'package:flutter/material.dart';
//import 'package:easy_search_bar/easy_search_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../Moedas/moeda.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../Repositories/compradas_repository.dart';
import '../configs/app_settings.dart';

import '../resources/text_style.dart';

class CarteiraPage extends StatefulWidget {
  const CarteiraPage({super.key});

  @override
  State<CarteiraPage> createState() => _CarteiraPageState();
}

class _CarteiraPageState extends State<CarteiraPage> {
  String searchValue = '';
  final tabela = MoedaRepository.tabela;
  late Map<String, String> loc;
  late NumberFormat real;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;
  late  SaldoComprada valor;

  late CompradasRepository compradas;

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
        backgroundColor: const Color.fromARGB(255, 26, 35, 29),
        title: const Text(
          "Carteira",
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
    favoritas = Provider.of<FavoritasRepository>(context);
    compradas = Provider.of<CompradasRepository>(context);
     valor = Provider.of<SaldoComprada>(context);
    readNumberFormat();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarDinamica(),
      body: Container(
        alignment: Alignment.topCenter,
        child: Consumer<CompradasRepository>(
          builder: (context, compradas, child) {
            return (compradas.compra.isEmpty)
                ? const ListTile(
                    leading: Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    title: Text(
                      'Ainda não há moedas compradas',
                      style: CriptoTextStyle.textfavorite,
                    ),
                  )
                : ListView.separated(
                    separatorBuilder: (__, ___) => const Divider(),
                    padding: const EdgeInsets.all(16),
                    itemCount: compradas.compra.length,
                    itemBuilder: (_, moeda) {
                      return InkWell(
                        child: ListTile(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          leading: Column(
                            children: [
                              SizedBox(
                                  width: 20,
                                  child: Image.asset(
                                      compradas.compra[moeda].icone)),
                                      const SizedBox(height: 8,),
                              Text(compradas.compra[moeda].sigla,
                                  style: CriptoTextStyle.fontSigla),
                            ],
                          ),
                          title: Text(compradas.compra[moeda].nome,
                              style: CriptoTextStyle.fontMoeda),
                          // trailing: 
                          
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
