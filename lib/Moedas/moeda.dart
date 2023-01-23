class Moeda {
  bool isSelected;
  String icone;
  String nome;
  String sigla;
  double preco;

  Moeda(
      {required this.icone,
      required this.nome,
      required this.sigla,
      required this.preco,
      required this.isSelected});
}
