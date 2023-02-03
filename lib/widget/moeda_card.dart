import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:app_cripto/Moedas/moeda.dart';
import 'package:app_cripto/pages/mostrar_detalhes_page.dart';

import '../Repositories/foavoritas_repository.dart';
import '../Repositories/moeda_repositories.dart';
import '../configs/app_settings.dart';
import '../resources/text_style.dart';

// ignore: must_be_immutable
class MoedaCard extends StatefulWidget {
  Moeda moeda;

  MoedaCard({
    Key? key,
    required this.moeda,
  }) : super(key: key);

  @override
  State<MoedaCard> createState() => _MoedaCardState();
}

// final tabela = MoedaRepository.tabela;

class _MoedaCardState extends State<MoedaCard> {
  late FavoritasRepository favoritas;
  List<Moeda> selecionadasFav = [];
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

  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MostrarDetalhesPage(moeda: widget.moeda),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    return Card(
      color: Colors.black,
      child: InkWell(
        child: ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          leading: SizedBox(width: 35, child: Image.asset(widget.moeda.icone)),
          title: Text(widget.moeda.nome, style: CriptoTextStyle.fontMoeda),
          subtitle: Text(widget.moeda.sigla, style: CriptoTextStyle.fontSigla),
          trailing: SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(real.format(widget.moeda.preco),
                    style: CriptoTextStyle.fontPreco),
                IconButton(
                  icon: const Icon(Icons.favorite),
                  color: const Color.fromARGB(255, 205, 205, 205),
                  onPressed: () {
                    setState(() {
                      Provider.of<FavoritasRepository>(context, listen: false)
                          .remove(widget.moeda);
                    });
                  },
                )
              ],
            ),
          ),
          onTap: (() => abrirDetalhes()),
        
        ),
      ),
    );
  }
}
