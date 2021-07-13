// import 'package:easycontab/contants/app_api_urls.dart';
// import 'package:easycontab/models/Categoria.dart';
// import 'package:easycontab/services/CategoriaService.dart';
// import 'package:searchfield/searchfield.dart';
// import 'package:flutter/material.dart';
//
// class FilterableSelectField extends StatefulWidget {
//
//   Categoria categoria;
//
//   FilterableSelectField({ this.categoria });
//
//   @override
//   _FilterableSelectFieldState createState() => _FilterableSelectFieldState();
// }
//
// class _FilterableSelectFieldState extends State<FilterableSelectField> {
//
//   CategoriaService service = new CategoriaService(
//     prefix: ApiUrls.prefix,
//     host: ApiUrls.hostqst ,
//     path: "qst/doubts",
//   );
//
//   List<Categoria> categorias = [];
//
//   void loadCategorias(){
//     this.service.getCategorias().then((response) => {
//       setState((){
//         this.categorias = response;
//       })
//     });
//   }
//
//   _FilterableSelectFieldState(){
//     this.loadCategorias();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//     );
//   }
// }
//
//
//
// // import 'package:find_dropdown/find_dropdown.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:flutter/material.dart';
//
//
// // class CidadeSelectField extends StatelessWidget {
//
// //   // Final Atributtes
// //   final dynamic cidadeCallback;
//
// //   // Constructor
// //   CidadeSelectField({ @required this.cidadeCallback });
//
// //   // Useful Atributtes
// //   GlobalKey<FindDropdownState> cidadesKey = GlobalKey<FindDropdownState>();
// //   CidadeService service = new CidadeService(resource: "cidades/");
// //   FindDropdown dropdown;
// //   List<Cidade> cidades;
// //   Cidade cidade = Cidade(cdCidade: 3306, dsCidade: "FOZ DO IGUAÇU", dsUf: "PR", nrCep: "85851-000", estrangeira: false);
//
// //   // Widget Methos
// //   FindDropdown getDropdown(){
// //     this.dropdown = FindDropdown(
// //       items: this.cidades,
// //       key: this.cidadesKey,
// //       onChanged: (dynamic cidade){
// //         this.cidade = cidade;
// //         this.cidadeCallback(cidade);
// //         this.cidadesKey.currentState.setSelectedItem(Cidade(cdCidade: 5,dsCidade: "Teste"));
// //       },
// //       selectedItem: this.cidade,
// //     );
// //     return this.dropdown;
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return FutureBuilder(
// //       future: this.service.getCidades(),
// //       builder: (context, snapshot){
// //         switch(snapshot.connectionState){
// //           case ConnectionState.none:
// //             // your code here
// //           case ConnectionState.waiting:
// //             return CircularProgressIndicator();
// //             break;
// //           case ConnectionState.active:
// //             // your code here
// //           case ConnectionState.done:
// //             if(snapshot.hasError){
// //               return Text(
// //                 "Não foi possível carregar os dados",
// //                 style: GoogleFonts.openSans(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500)
// //               );
// //             }else{
// //               this.cidades = snapshot.data;
// //               return this.getDropdown();
// //             }
// //           break;
// //         }
// //       }
// //     );
// //   }
// // }
//
//
// // typedef void Callback(Cidade cidade);
//
//
// // class CidadeSelect extends StatefulWidget {
//
// //   final List<Cidade> cidades;
// //   final Callback onCidadeChanged;
// //   Cidade cidade;
//
// //   CidadeSelect({this.cidades, @required this.onCidadeChanged, @required cidade});
//
// //   @override
// //   _CidadeSelectState createState() => _CidadeSelectState();
// // }
//
// // class _CidadeSelectState extends State<CidadeSelect> {
//
// //   dynamic _cidade = "Cidade";
//
// //   void setCidade(Cidade cidade){
// //     setState(() {
// //       this._cidade = cidade;
// //     });
// //   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return FindDropdown(
// //       items: this.widget.cidades,
// //       onChanged: (dynamic cidade){
// //         this._cidade = cidade;
// //         this.widget.onCidadeChanged(cidade);
// //         print(this.widget.cidade);
// //       },
// //       selectedItem: this._cidade,
// //     );
// //   }
// // }
//
//
//
//
//
