
import 'package:easycontab/components/ComentarioComponent.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/services/RespostaService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'misc/IconCount.dart';

class RespostaComponent extends StatefulWidget {

  Resposta resposta;

  RespostaComponent({ this.resposta });

  @override
  _RespostaComponentState createState() => _RespostaComponentState();
}

class _RespostaComponentState extends State<RespostaComponent> {
  RespostaService service = new RespostaService(
    prefix: ApiUrls.prefix,
    host: ApiUrls.hostqst ,
    path: "qst/answers",
  );

  List<ComentarioComponent> showComentarios() {
    List<ComentarioComponent> comentarios = [];

    for( var comentario in this.widget.resposta.comentarios ) {
      comentarios.add(
          ComentarioComponent(comentario: comentario)
      );
    }

    return comentarios;
  }

  bool comentariosVisible = true;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
      padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6),
            child: Container(                 
              child: Text(
                this.widget.resposta.conteudo,
                style: GoogleFonts.openSans( color: Color.fromRGBO(161,161,161,1), fontSize: 9, fontWeight: FontWeight.w600),
                overflow: TextOverflow.clip,                   
              ),
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
                  onTap: () {
                    this.widget.resposta.reacaoResposta = true;

                    this.service.updateResposta(id: this.widget.resposta.id, resposta: this.widget.resposta).then((response) => {
                      setState(() {
                        this.widget.resposta = response;
                      })
                    });
                  }
              ),
              GestureDetector(
                  child: IconCount(count: this.widget.resposta.nrDesaprovacoes, icon: Icons.thumb_down, size: 18 ),
                  onTap: () {
                    this.widget.resposta.reacaoResposta = false;

                    this.service.updateResposta(id: this.widget.resposta.id, resposta: this.widget.resposta).then((response) => {
                      setState(() {
                        this.widget.resposta = response;
                      })
                    });
                  }
              ),
            ],
          ),
          Column(
            children: this.comentariosVisible == true ? this.showComentarios() : [],
          )
        ]
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
    );
  }
}


