
import 'package:easycontab/components/ComentarioComponent.dart';
import 'package:easycontab/components/ComentarioComponentCreate.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/EditarResposta.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:easycontab/services/ComentarioService.dart';
import 'package:easycontab/services/RespostaService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'misc/IconCount.dart';

class RespostaComponent extends StatefulWidget {

  Duvida duvida;
  Resposta resposta;

  RespostaComponent({ this.resposta, this.duvida });

  @override
  _RespostaComponentState createState() => _RespostaComponentState();
}

class _RespostaComponentState extends State<RespostaComponent> {
  Usuario usuario = new Usuario();

  Preferences preferences = new Preferences();

  setUser() {
    this.preferences.init().then((value) => {
      setState(() {
        this.usuario = this.preferences.getUser();
      })
    });
  }

  _RespostaComponentState() {
    setUser();
  }

  String comentario;

  void setComentario(String comentario){
    this.comentario = comentario;
  }

  RespostaService service = new RespostaService(
    prefix: ApiUrls.prefix,
    host: ApiUrls.hostqst ,
    path: "qst/answers",
  );

  List<Widget> showComentarios() {
    List<Widget> comentarios = [];

    for( var comentario in this.widget.resposta.comentarios ) {
      comentarios.add(
          ComentarioComponent(comentario: comentario, duvidaId: this.widget.resposta.duvida.id)
      );
    }
    comentarios.add(ComentarioComponentCreate(controller: new TextEditingController(), resposta: this.widget.resposta, callback: this.setComentario,));

    return comentarios;
  }

  bool comentariosVisible = true;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
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
                      this.widget.resposta.usuario.foto != null ? Image.network(this.widget.resposta.usuario.foto, width: 25, height: 25, fit: BoxFit.fitWidth) : Image.asset(Assets.avatar, width: 25, height: 25, fit: BoxFit.fitWidth)
                    ],
                  ),
                  onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => Perfil(editable: false, usuario: this.widget.resposta.usuario)) );
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
                                  this.widget.resposta.conteudo,
                                  style: GoogleFonts.openSans( color: Color.fromRGBO(78,76,76,1), fontSize: 12, fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.clip
                              )
                            ),
                          ]
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              child: IconCount(count: this.widget.resposta.nrComentarions, icon: Icons.question_answer, size: 18, ),
                              onTap: (){
                                setState(() {
                                  this.comentariosVisible = !this.comentariosVisible;
                                });
                              }
                          ),
                          GestureDetector(
                              child: IconCount(count: this.widget.resposta.nrAprovacoes, icon: Icons.thumb_up, size: 18, ),
                              onTap: this.usuario.id == this.widget.resposta.usuario.id ? () {
                                // TODO USUARIO NAO PODE REAGIR A PROPRIA RESPOSTA
                              } : () {
                                this.widget.resposta.reacaoResposta = true;

                                this.service.reagirDuvida(id: this.widget.resposta.id, resposta: this.widget.resposta).then((response) => {
                                  setState(() {
                                    this.widget.resposta = response;
                                  })
                                });
                              }
                          ),
                          GestureDetector(
                              child: IconCount(count: this.widget.resposta.nrDesaprovacoes, icon: Icons.thumb_down, size: 18 ),
                              onTap: this.usuario.id == this.widget.resposta.usuario.id ? () {
                                // TODO USUARIO NAO PODE REAGIR A PROPRIA RESPOSTA
                              } : () {
                                this.widget.resposta.reacaoResposta = false;

                                this.service.reagirDuvida(id: this.widget.resposta.id, resposta: this.widget.resposta).then((response) => {
                                  setState(() {
                                    this.widget.resposta = response;
                                  })
                                });
                              }
                          ),
                          this.usuario.id == this.widget.resposta.usuario.id ? GestureDetector(
                            child: IconCount(icon: Icons.edit),
                            onTap: () {
                              Navigator.push( context, MaterialPageRoute(builder: (context) => EditarResposta(resposta: this.widget.resposta)) );
                            },
                          ) : Text("")
                        ],
                      ),
                    ]
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: this.widget.resposta.resolveu == true ? Border(left: BorderSide(color: Colors.green[800], width: 8, style: BorderStyle.solid )) : null
              ,boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1,3),
                  blurRadius: 3
                )
              ]
            ),
          ),
          Column(
            children: this.comentariosVisible == true ? this.showComentarios() : [],
          )
        ],
      ),
    );
  }
}


