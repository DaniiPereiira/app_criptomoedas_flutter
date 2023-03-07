// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Moedas/moeda.dart';
import '../Repositories/foavoritas_repository.dart';
import '../Repositories/moeda_repositories.dart';
import '../configs/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:app_cripto/Repositories/conta_repository.dart';

import '../resources/text_style.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
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

  appBarDinamica() {
    return AppBar(
      actions: [
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
        "Configurações",
        style: CriptoTextStyle.titlePageCripto,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final conta = context.watch<ContaRepository>();
    final loc = context.read<AppSettings>().locale;
    NumberFormat real =
        NumberFormat.currency(locale: loc['locale'], name: loc['name']);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBarDinamica(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          ListTile(
            title: const Text(
              'Saldo',
              style: CriptoTextStyle.fontMoeda,
            ),
            subtitle: Text(
              real.format(conta.saldo),
              style: CriptoTextStyle.fontMoedaDetail,
            ),
            trailing:
                IconButton(onPressed: updateSaldo, icon: Icon(Icons.edit)),
          ),
          const Divider()
        ]),
      ),
    );
  }

  updateSaldo() async {
    final form = GlobalKey<FormState>();
    final valor = TextEditingController();
    final conta = context.read<ContaRepository>();

    valor.text = conta.saldo.toString();

    AlertDialog dialog = AlertDialog(
      title: ,
    );
  }
}
