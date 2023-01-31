// import 'package:app_cripto/Repositories/foavoritas_repository.dart';
// import 'package:app_cripto/Repositories/moeda_repositories.dart';
// import 'package:app_cripto/pages/mostrar_detalhes_page.dart';
// import 'package:flutter/material.dart';
// import 'package:easy_search_bar/easy_search_bar.dart';
// // ignore: depend_on_referenced_packages
// import 'package:intl/intl.dart';

// import '../Moedas/moeda.dart';
// // ignore: depend_on_referenced_packages
// import 'package:provider/provider.dart';
// import '../resources/strings.dart';
// import '../resources/text_style.dart';

// final tabela = MoedaRepository.tabela;
// List<Moeda> selecionadas = [];
// late FavoritasRepository favoritas;

// appBarDinamica() {
//   if (selecionadas.isEmpty) {
//     return AppBar(
//       actions: [
//         IconButton(
//           onPressed: () {
//             //  showSearch(context: context, delegate: );
//           },
//           icon: const Icon(Icons.search),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(right: 20.0),
//           child: PopupMenuButton(
//               icon: const Icon(Icons.more_vert),
//               itemBuilder: (context) => [
//                     PopupMenuItem(
//                         child: TextButton(
//                       child: const Text("Selecionar todas"),
//                       onPressed: () {
//                         setState(() {
//                           selecionadas.addAll(tabela);
//                         });

//                         Navigator.pop(context);
//                       },
//                     )),
//                     PopupMenuItem(
//                         child: TextButton(
//                       child: const Text("Remover todas"),
//                       onPressed: () {
//                         setState(() {
//                           selecionadas.clear();
//                         });

//                         Navigator.pop(context);
//                       },
//                     )),
//                   ]),
//         )
//       ],
//       backgroundColor: const Color.fromARGB(255, 26, 35, 29),
//       title: const Text("",
//       style: CriptoTextStyle.titlePageCripto, ),
//     );
//   } else {
//     return AppBar(
//       backgroundColor: const Color.fromARGB(255, 26, 35, 29),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.only(right: 20.0),
//           child: PopupMenuButton(
//               icon: const Icon(Icons.more_vert),
//               itemBuilder: (context) => [
//                     PopupMenuItem(
//                         child: TextButton(
//                       child: const Text("Selecionar todas"),
//                       onPressed: () {
//                         setState(() {
//                           selecionadas.addAll(tabela);
//                         });

//                         Navigator.pop(context);
//                       },
//                     )),
//                     PopupMenuItem(
//                         child: TextButton(
//                       child: const Text("Remover todas"),
//                       onPressed: () {
//                         setState(() {
//                           selecionadas.clear();
//                         });

//                         Navigator.pop(context);
//                       },
//                     )),
//                   ]),
//         )
//       ],
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: (() {
//           setState(() {
//             selecionadas = [];
//           });
//         }),
//       ),
//       title: Text("${selecionadas.length} selecionadas"),
//     );
//   }
// }

// void setState(Null Function() param0) {}
