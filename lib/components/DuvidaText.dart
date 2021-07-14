
import 'package:easycontab/components/DuvidaComponent.dart';
import 'package:easycontab/components/RespostaComponent.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:easycontab/services/RespostaService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'RespostaComponentCheckable.dart';

import 'misc/IconCount.dart';

class DuvidaText extends StatefulWidget {

  Duvida duvida;
  bool solving;
  bool respostasVisible;

  DuvidaText({this.duvida, this.respostasVisible = false, this.solving = false});

  @override
  _DuvidaTextState createState() => _DuvidaTextState(this.duvida.id, this.respostasVisible);
}


class _DuvidaTextState extends State<DuvidaText> {

  RespostaService respostaService = new RespostaService(prefix: ApiUrls.prefix, host: ApiUrls.hostqst, path: "qst/answers");
  DuvidaService duvidaService = new DuvidaService(prefix: ApiUrls.prefix, host: ApiUrls.hostqst, path: "qst/doubts");

  Preferences preferences = new Preferences();
  Usuario usuario = new Usuario();

  // ESSE CARA É MUITO IMPORTANTE
  List<GlobalKey<RespostaComponentCheckableState>> keys = [];
  GlobalKey<RespostaComponentCheckableState> key;

  List<Resposta> respostas = [];
  dynamic selectedSolve;
  bool respostasVisible;
  bool test = false;
  

  _DuvidaTextState(String id, bool respostasVisible) {
    this.respostasVisible = respostasVisible;
    this.respostaService.queryPath = "*deletedAt=null&_answerReactions=[]&_user=[]&_comments=[\"user\"]&*doubtId=${id}";
    getRespostas();
    setUser();
  }

  setSelectedSolve(dynamic key, dynamic value){
    this.selectedSolve = value;
    this.keys.forEach((ckey) {
      if (ckey != key){
        ckey.currentState.setChecked(false);
      }
    });
    //key.currentState.printPotatos();
  }

  getRespostas() {
    this.respostaService.getRespostas(loadDependencies: true).then((response) => {
      setState(() {
        this.respostas = response;
        this.keys = this.respostas.map((e) => new GlobalKey<RespostaComponentCheckableState>()).toList();
      })
    });
  }

  showError(String msg){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(msg, style: GoogleFonts.openSans( color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,))
        )
    );
  }

  setUser() {
    this.preferences.init().then((value) => {
      setState(() {
        this.usuario = this.preferences.getUser();
      })
    });
  }


  List<RespostaComponentCheckable> showRespostasToSolve() {
    List<RespostaComponentCheckable> respostas = [];

    this.respostas.asMap().forEach((index, resposta) {
      respostas.add(
        RespostaComponentCheckable(resposta: resposta, duvida: this.widget.duvida, onCheck: setSelectedSolve, key: this.keys[index],)
      );
    });

    // for( var resposta in this.respostas ) {
    //   respostas.add(
    //       RespostaComponentCheckable(resposta: resposta, duvida: this.widget.duvida, onCheck: setSelectedSolve, key: keyState,)
    //   );
    // }
    return respostas;
  }

  List<RespostaComponent> showRespostas() {
    List<RespostaComponent> respostas = [];

    for( var resposta in this.respostas ) {
      respostas.add(
        RespostaComponent(resposta: resposta, duvida: this.widget.duvida)
      );
    }
    return respostas;
  }

  List<Widget> getContent(){
    if(this.widget.solving == true){
      return this.showRespostasToSolve();
    }
    return this.showRespostas();
  }

  
  //final GlobalKey<_RespostaComponentCheckableState> _RespostaComponentCheckableState = GlobalKey<_RespostaComponentCheckableState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
            padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: this.widget.duvida.usuario.foto != null ? Image.network(this.widget.duvida.usuario.foto, width: 25, height: 25, fit: BoxFit.fitWidth) : Image.asset(Assets.avatar, width: 25, height: 25, fit: BoxFit.fitWidth)          
                      ),                     
                    ],
                  ),
                  onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => Perfil(editable: false, usuario: this.widget.duvida.usuario)) );
                  },
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: size.width * 0.70,
                              child: Text(
                                this.widget.duvida.titulo ?? '',
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans( color: Color.fromRGBO(78,76,76,1), fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              width: size.width * 0.70,
                              child: Text(
                                this.widget.duvida.descricao ?? '',
                                style: GoogleFonts.openSans( color: Color.fromRGBO(161,161,161,1), fontSize: 9, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              child: IconCount(count: this.widget.duvida.nrRespostas, icon: Icons.messenger_sharp, size: 18, ),
                              onTap: (){
                                setState(() {
                                  this.respostasVisible = !this.respostasVisible;
                                });
                              }
                          ),
                          GestureDetector(
                              child: IconCount(count: this.widget.duvida.nrAprovacoes, icon: Icons.thumb_up, size: 18, ),
                              onTap: this.usuario.id == this.widget.duvida.usuario.id ? () {
                                this.showError("Não é possível o usuário reagir a própria dúvida");
                              } : () {
                                this.widget.duvida.reacaoDuvida = true;

                                this.duvidaService.reagirDuvida(id: this.widget.duvida.id, duvida: this.widget.duvida).then((response) => {
                                  setState(() {
                                    this.widget.duvida = response;
                                  })
                                });
                              }
                          ),
                          GestureDetector(
                              child: IconCount(count: this.widget.duvida.nrDesaprovacoes, icon: Icons.thumb_down, size: 18 ),
                              onTap: this.usuario.id == this.widget.duvida.usuario.id ? () {
                                this.showError("Não é possível o usuário reagir a própria dúvida");
                              } : () {
                                this.widget.duvida.reacaoDuvida = false;

                                this.duvidaService.reagirDuvida(id: this.widget.duvida.id, duvida: this.widget.duvida).then((response) => {
                                  setState(() {
                                    this.widget.duvida = response;
                                  })
                                });
                              }
                          ),
                        ],
                      ),
                    ]
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: this.widget.solving == false ? Colors.white : Colors.green[50]
                ,borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow( 
                  color: Colors.grey,
                  offset: Offset(1,3),
                  blurRadius: 3
                )
              ]
            ),
          ),
          Column(
              children: this.respostasVisible == true ? this.getContent() : []
          ),
        ],
      ),
    );
  }
}

// SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Container(
//               width: 600,
//               child: Row(
//                 children: [
//                   Checkbox(value: false, onChanged: (value){print(value);}),
//                   this.respostasVisible == true ? RespostaComponent(resposta: this.widget.duvida.respostas.first, duvida: this.widget.duvida) : Text("TESTE"),
//                 ],
//               ),
//             ),
//           ),

                      
