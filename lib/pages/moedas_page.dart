import 'package:app_cripto/Repositories/foavoritas_repository.dart';
import 'package:app_cripto/Repositories/moeda_repositories.dart';
import 'package:app_cripto/pages/mostrar_detalhes_page.dart';
import 'package:flutter/material.dart';
//import 'package:easy_search_bar/easy_search_bar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';


import '../Moedas/moeda.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../configs/app_settings.dart';

import '../resources/text_style.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({super.key});

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  String searchValue = '';
  final tabela = MoedaRepository.tabela;
  late Map<String, String> loc;
  late NumberFormat real;
  List<Moeda> selecionadas = [];
  late FavoritasRepository favoritas;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
            child: ListTile(
                leading: Icon(Icons.swap_vert),
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
                        child: const Text("Selecionar todas"),
                        onPressed: () {
                          setState(() {
                            selecionadas.addAll(tabela);
                          });

                          Navigator.pop(context);
                        },
                      )),
                      PopupMenuItem(
                          child: TextButton(
                        child: const Text("Remover todas"),
                        onPressed: () {
                          setState(() {
                            selecionadas.clear();
                          });

                          Navigator.pop(context);
                        },
                      )),
                    ]),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 26, 35, 29),
        title: const Text(
          "Criptomoedas",
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
                        child: const Text("Selecionar todas"),
                        onPressed: () {
                          setState(() {
                            selecionadas.addAll(tabela);
                          });

                          Navigator.pop(context);
                        },
                      )),
                      PopupMenuItem(
                          child: TextButton(
                        child: const Text("Remover todas"),
                        onPressed: () {
                          setState(() {
                            selecionadas.clear();
                          });

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

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => MostrarDetalhesPage(moeda: moeda)));
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    favoritas = Provider.of<FavoritasRepository>(context);
    readNumberFormat();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarDinamica(),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int moeda) {
            return ListTile(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                leading: (selecionadas.contains(tabela[moeda]))
                    ? const CircleAvatar(
                        // ignore: sort_child_properties_last
                        child: Icon(Icons.check),
                        backgroundColor: (Color.fromARGB(255, 49, 92, 50)),
                      )
                    : SizedBox(
                        width: 35, child: Image.asset(tabela[moeda].icone)),
                title:
                    Text(tabela[moeda].nome, style: CriptoTextStyle.fontMoeda),
                subtitle:
                    Text(tabela[moeda].sigla, style: CriptoTextStyle.fontSigla),
                trailing: (favoritas.lista.contains(tabela[moeda]))
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        color: const Color.fromARGB(255, 205, 205, 205),
                        onPressed: () {
                          setState(() {
                            favoritas.remove(tabela[moeda]);
                          });
                        },
                      )
                    : Text(real.format(tabela[moeda].preco),
                        style: CriptoTextStyle.fontPreco),
                selected: selecionadas.contains(tabela[moeda]),
                selectedTileColor: const Color.fromARGB(255, 209, 208, 208),
                onLongPress: () {
                  setState(() {
                    (selecionadas.contains(tabela[moeda]))
                        ? selecionadas.remove(tabela[moeda])
                        : selecionadas.add(tabela[moeda]);
                  });
                },
                onTap: (() => mostrarDetalhes(tabela[moeda])));
          },
          padding: const EdgeInsets.all(16),
          separatorBuilder: (__, ___) => const Divider(),
          itemCount: tabela.length),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: (selecionadas.isNotEmpty)
          ? FloatingActionButton.extended(
              backgroundColor: const Color.fromARGB(255, 26, 35, 29),
              onPressed: (() {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              }),
              label: const Text("Favorito"),
              icon: const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 194, 194, 194),
              ))
          : null,
    );
  }
}
