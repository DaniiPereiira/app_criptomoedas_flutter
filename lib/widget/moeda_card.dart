import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:app_cripto/Moedas/moeda.dart';
import 'package:app_cripto/pages/mostrar_detalhes_page.dart';

import '../Repositories/foavoritas_repository.dart';
import '../Repositories/moeda_repositories.dart';
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
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  late FavoritasRepository favoritas;
  List<Moeda> selecionadasFav = [];
  final tabela = MoedaRepository.tabela;

  abrirDetalhes() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MostrarDetalhesPage(moeda: widget.moeda),
      ),
    );
  }

  selecionarMoeda() {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      (selecionadasFav.contains(widget.moeda))
          ? selecionadasFav.remove(widget.moeda)
          : selecionadasFav.add(widget.moeda);
      return const CircleAvatar(
                  // ignore: sort_child_properties_last
                  child: Icon(Icons.check),
                  backgroundColor: (Color.fromARGB(255, 49, 92, 50)),
                );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: InkWell(
        child: ListTile(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          leading: (selecionadasFav.contains(widget.moeda))
              ? const CircleAvatar(
                  // ignore: sort_child_properties_last
                  child: Icon(Icons.check),
                  backgroundColor: (Color.fromARGB(255, 49, 92, 50)),
                )
              : SizedBox(width: 35, child: Image.asset(widget.moeda.icone)),
          title: Text(widget.moeda.nome, style: CriptoTextStyle.fontMoeda),
          subtitle: Text(widget.moeda.sigla, style: CriptoTextStyle.fontSigla),
          trailing: Text(real.format(widget.moeda.preco),
              style: CriptoTextStyle.fontPreco),
          onTap: (() => abrirDetalhes()),
          onLongPress: () {
            setState(() {
              (selecionadasFav.contains(widget.moeda))
                  ? selecionadasFav.remove(widget.moeda)
                  : selecionadasFav.add(widget.moeda);
            });
          },
        ),
      ),
    );
  }
}
