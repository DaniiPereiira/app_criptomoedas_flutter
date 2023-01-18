import '../Moedas/moeda.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
        icone: "assets/images/btcoin.png",
        nome: "Biticoin",
        sigla: "BTC",
        preco: 164603),
    Moeda(
        icone: "assets/images/ethereum.png",
        nome: "Ethereum",
        sigla: "ETH",
        preco: 9716),
    Moeda(
        icone: "assets/images/utd.png", nome: "XRP", sigla: "XRP", preco: 3.34),
    Moeda(
        icone: "assets/images/cardano.jpg",
        nome: "Cardano",
        sigla: "ADA",
        preco: 6.32),
    Moeda(
        icone: "assets/images/ucoin.png",
        nome: "USD Coins",
        sigla: "USD",
        preco: 5.02),
    Moeda(
        icone: "assets/images/ltcoin.png",
        nome: 'Litecoin',
        sigla: "LTD",
        preco: 669.93),
  ];
}
