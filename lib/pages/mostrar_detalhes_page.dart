import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import '../Moedas/moeda.dart';
import '../Repositories/compradas_repository.dart';
import '../Repositories/moeda_repositories.dart';
import '../resources/text_style.dart';

// ignore: must_be_immutable
class MostrarDetalhesPage extends StatefulWidget {
  Moeda moeda;

  MostrarDetalhesPage({Key? key, required this.moeda}) : super(key: key);

  @override
  State<MostrarDetalhesPage> createState() => _MostrarDetalhesPageState();


}

class _MostrarDetalhesPageState extends State<MostrarDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final _form = GlobalKey<FormState>();
  final _valor = TextEditingController();
  double quantidade = 0;
  List quantidadeComprada = [];
  List<Moeda> selecionadas = [];
  late CompradasRepository compradas;
  final tabela = MoedaRepository.tabela;
late  SaldoComprada valor;

  comprar() {
    if (_form.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Compra realizada com sucesso'),
      ));
    }
  }

  salvarCarteira() {
    setState(() {
      (compradas.compra.contains(widget.moeda))
          ? null
          : selecionadas.add(widget.moeda);

      compradas.saveAll(selecionadas);
    });
  }

 

      salvarValor() {
    valor.lista.add(quantidade);
    (valor.lista.isEmpty) ? quantidade : 0;
  }

  



  @override
  Widget build(BuildContext context) {
    compradas = Provider.of<CompradasRepository>(context);
    valor = Provider.of<SaldoComprada>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 26, 35, 29),
        title: Text(widget.moeda.nome, style: CriptoTextStyle.titlePageDetail),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(widget.moeda.icone),
                  ),
                  Container(
                    width: 30,
                  ),
                  Text(
                    real.format(widget.moeda.preco),
                    style: CriptoTextStyle.fontMoedaDetail,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
              key: _form,
              child: TextFormField(
                controller: _valor,
                style: CriptoTextStyle.valorMoedaDetail,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    prefixIcon: Icon(
                      Icons.monetization_on_outlined,
                      color: Color.fromARGB(255, 159, 161, 158),
                    ),
                    suffixIcon: Text(
                      'reais',
                      textAlign: TextAlign.right,
                      style: CriptoTextStyle.valorNomeDetail,
                    ),
                    labelText: 'Digite o valor que deseja converter',
                    labelStyle: CriptoTextStyle.valorNomeDetail,
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (value) {
                  setState(() {
                    quantidade = (value.isEmpty)
                        ? 0
                        : double.parse(value) / widget.moeda.preco;
                  });
                },
                validator: ((value) {
                  if (value!.isEmpty) {
                    return "Informe o valor da Compra";
                  } else if (double.parse(value) < 50) {
                    return "Compa mínima é R\$ 50,00";
                  }
                  return null;
                }),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            quantidade > 0
                ? Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 92, 93, 92),
                        borderRadius: BorderRadius.circular(8)),
                    height: 50,
                    width: 300,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        '$quantidade ${widget.moeda.sigla}',
                        textAlign: TextAlign.center,
                        style: CriptoTextStyle.quantidadeDetail,
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(
              height: 25,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor:
                      MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const Color.fromARGB(255, 1, 130, 5);
                    }
                    return const Color.fromARGB(255, 12, 81, 21);
                  })),
                  onPressed: () {
                    comprar();
                    setState(() {
                      salvarCarteira();
                      salvarValor();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.check),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "Comprar",
                          style: CriptoTextStyle.comprarDetail,
                        ),
                      )
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
