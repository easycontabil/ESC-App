
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Comentario.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/Duvida.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:easycontab/services/ComentarioService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ComentarioComponentCreate extends StatefulWidget {

  dynamic callback;

  final Resposta resposta;
  final TextEditingController controller;
  

  ComentarioComponentCreate({ this.controller, this.callback, this.resposta });

  @override
  _ComentarioComponentCreateState createState() => _ComentarioComponentCreateState();
}

class _ComentarioComponentCreateState extends State<ComentarioComponentCreate> {
  Usuario usuario = new Usuario();
  Preferences preferences = new Preferences();

  setUser() {
    this.preferences.init().then((value) => {
      setState(() {
        this.usuario = this.preferences.getUser();
      })
    });
  }

  _ComentarioComponentCreateState() {
    setUser();
  }

  bool loading = false;
  bool created = false;

  ComentarioService service = new ComentarioService(
    prefix: ApiUrls.prefix,
    host: ApiUrls.hostqst ,
    path: "qst/comments",
  );


  List<Widget> getContent(){
    return [
      Padding(
        padding: EdgeInsets.only(top: 0),
        child: Container(
            child: TextField(
              controller: this.widget.controller,
              decoration: InputDecoration(
                  labelText: "COMENTÁRIO",
                  labelStyle: GoogleFonts.openSans( fontSize: 9)
              ),
            )
        ),
      ),
      TextButton(
        child: Text("COMENTAR"),
        onPressed: (){
          this.widget.callback( this.widget.controller.text );
          this.service.registerComentario(Comentario(comentario: this.widget.controller.text, resposta: this.widget.resposta)).then((value) => {
            setState((){
              Navigator.push( context, MaterialPageRoute(builder: (context) => VerDuvida(duvidaId: this.widget.resposta.duvida.id, respostas: true)) );
            })
          });
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
      padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
      child: Column(
        crossAxisAlignment: this.created == true ? CrossAxisAlignment.start : CrossAxisAlignment.end ,
        children: this.getContent()
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


