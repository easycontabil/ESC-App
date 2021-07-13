
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Comentario.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ComentarioComponent extends StatefulWidget {

  //final Usuario dono;
  // final String conteudo;
  Comentario comentario;
  final controller = new TextEditingController();

  ComentarioComponent({ /*@required this.dono,*/ @required this.comentario });

  @override
  _ComentarioComponentState createState() => _ComentarioComponentState();
}

class _ComentarioComponentState extends State<ComentarioComponent> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
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
                this.widget.comentario.usuario.foto != null ? Image.network(this.widget.comentario.usuario.foto, width: 25, height: 25, fit: BoxFit.fitWidth) : Image.asset(Assets.avatar, width: 25, height: 25, fit: BoxFit.fitWidth)
              ],
            ),
            onTap: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => Perfil(editable: false, usuario: this.widget.comentario.usuario)) );
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
                        child: Text(
                          this.widget.comentario.comentario,
                          style: GoogleFonts.openSans( color: Color.fromRGBO(161,161,161,1), fontSize: 9, fontWeight: FontWeight.w600),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  )
                ),
              ]
          ),
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


