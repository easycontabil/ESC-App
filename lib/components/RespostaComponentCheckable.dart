
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:easycontab/services/RespostaService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'misc/IconCount.dart';

class RespostaComponentCheckable extends StatefulWidget {

  final Resposta resposta;
  final Duvida duvida;
  final dynamic onCheck;

  RespostaComponentCheckable({ this.resposta, this.duvida, this.onCheck, Key key }) : super(key: key);

  @override
  RespostaComponentCheckableState createState() => RespostaComponentCheckableState();
}

class RespostaComponentCheckableState extends State<RespostaComponentCheckable> {

  RespostaService service = new RespostaService(prefix: ApiUrls.prefix, host: ApiUrls.hostqst, path: "qst/answers");

  String comentario;
  bool checked = false;

  void setComentario(String comentario){
    this.comentario = comentario;
  }

  setChecked(bool value){
    setState(() {
      this.checked = value;      
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container( 
        padding: EdgeInsets.only(left: 12),
        width: 600,  
        child: Row(
          children: [
            Checkbox(
              value: this.checked, 
              onChanged: (value){
                this.setChecked(value);
                if(value == true){
                  this.widget.onCheck( this.widget.key, this.widget.resposta);     
                }else{
                  this.widget.onCheck( null, null); 
                }        
              }
            ),
            Container(
              width: 400,//size.width * 1,
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
                                IconCount(count: this.widget.resposta.nrComentarions, icon: Icons.question_answer, size: 18, ),
                                IconCount(count: this.widget.resposta.nrAprovacoes, icon: Icons.thumb_up, size: 18, ),
                                IconCount(count: this.widget.resposta.nrDesaprovacoes, icon: Icons.thumb_down, size: 18 )
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
                ],
              ),
            )
          ],
        ),
      ),           
    );
  }
}


