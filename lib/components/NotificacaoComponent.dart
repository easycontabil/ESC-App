
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Notificacao.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'misc/IconCount.dart';


class NotificacaoComponent extends StatefulWidget {

  final Notificacao notificacao;

  NotificacaoComponent({ this.notificacao });

  @override
  _NotificacaoComponentState createState() => _NotificacaoComponentState();
}

class _NotificacaoComponentState extends State<NotificacaoComponent> {
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
          Text(this.widget.notificacao.titulo, overflow: TextOverflow.ellipsis, style: GoogleFonts.openSans( color: Color.fromRGBO(78,76,76,1), fontSize: 16, fontWeight: FontWeight.w600)),
          Text(this.widget.notificacao.conteudo, overflow: TextOverflow.ellipsis, style: GoogleFonts.openSans( color: Color.fromRGBO(78,76,76,1), fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
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


