
import 'package:easycontab/components/DuvidaComponent.dart';
import 'package:easycontab/components/RespostaComponent.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'misc/IconCount.dart';

class DuvidaText extends StatefulWidget {

  Duvida duvida;

  DuvidaText(@required this.duvida);

  @override
  _DuvidaTextState createState() => _DuvidaTextState();
}

class _DuvidaTextState extends State<DuvidaText> {

  DuvidaService service = new DuvidaService(
    prefix: ApiUrls.prefix,
    host: ApiUrls.hostqst ,
    path: "qst/doubts",
  );

  bool respostasVisible = false;

  List<RespostaComponent> showRespostas(){
    List<RespostaComponent> respostas = [];

    for( var resposta in this.widget.duvida.respostas ){
      respostas.add(
        RespostaComponent(
          conteudo: resposta.conteudo,
          nrComentarios: resposta.comentarios != null ? resposta.comentarios.length : 0,
          nrCurtidas: resposta.nrAprovacoes ?? 0,
          nrDescurtidas: resposta.nrDesaprovacoes ?? 0,
          resolveu: resposta.resolveu ?? false
        )
      );
    }
    return respostas;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
            padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(            
                        child: Text(
                          this.widget.duvida.titulo, 
                          overflow: TextOverflow.clip, 
                          style: GoogleFonts.openSans( color: Color.fromRGBO(78,76,76,1), fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ),                     
                      Container(                 
                        child: Text(
                          this.widget.duvida.descricao,
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
                      child: IconCount(count: this.widget.duvida.nrRespostas ?? 0, icon: Icons.messenger_sharp, size: 18, ),
                      onTap: (){
                        setState(() { 
                          this.respostasVisible = !this.respostasVisible;
                        });
                      }
                    ),
                    GestureDetector(
                      child: IconCount(count: this.widget.duvida.nrAprovacoes, icon: Icons.thumb_up, size: 18, ),
                      onTap: () {
                        this.widget.duvida.reacaoDuvida = true;

                        this.service.updateDuvida(id: this.widget.duvida.id, duvida: this.widget.duvida).then((response) => {
                          setState(() {
                            this.widget.duvida = response;
                          })
                        });
                      }
                    ),
                    GestureDetector(
                        child: IconCount(count: this.widget.duvida.nrDesaprovacoes, icon: Icons.thumb_down, size: 18 ),
                        onTap: () {
                          this.widget.duvida.reacaoDuvida = false;

                          this.service.updateDuvida(id: this.widget.duvida.id, duvida: this.widget.duvida).then((response) => {
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(1),
              boxShadow: [
                BoxShadow( 
                  color: Colors.grey,
                  offset: Offset(1,3),
                  blurRadius: 3
                )
              ]
            ),
          ),
          //SizedBox( height: 5),
          Column(
            children: this.respostasVisible == true ? this.showRespostas() : [], 
            //this.respostasVisible == true ? Text("RESPOSTAS") : Text("SEM RESPOSTAS")
          )
        ],
      ),
    );
  }
}

                      
