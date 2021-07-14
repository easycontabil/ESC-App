
import 'package:easycontab/components/AppBar.dart';
import 'package:easycontab/components/BackgroundBaseWidget.dart';
import 'package:easycontab/components/Button.dart';
import 'package:easycontab/components/DataLine.dart';
import 'package:easycontab/components/DataText.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'EditarUsuario.dart';

class Perfil extends StatefulWidget {
  final Usuario usuario;
  final bool editable;

  Perfil({this.editable = false, this.usuario = null});

  @override
  _PerfilState createState() => _PerfilState(this.usuario);
}

class _PerfilState extends State<Perfil> {
  // DuvidaService duvidaService = new DuvidaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst , path: "qst/doubts");

  Usuario usuario = new Usuario();
  Preferences preferences = new Preferences();

  setUser(Usuario usuario) {
    if (usuario == null) {
      this.preferences.init().then((value) => {
        setState(() {
          this.usuario = this.preferences.getUser();
        })
      });
    } else {
      this.usuario = usuario;
    }
  }

  _PerfilState(Usuario usuario) {
    setUser(usuario);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBaseWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomAppBar(logged: true),
          // this.usuario == null ? CustomAppBar(logged: true) : CustomAppBar(),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 6, left: 6, right: 6),
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            child: Column(
              children: [
                SizedBox( height: 20 ),
                DataLine(dataLabel: "NOME COMPLETO", dataValue: this.usuario.nome, dataIcon: Icons.person),
                DataLine(dataLabel: "E-MAIL", dataValue: this.usuario.email, dataIcon: Icons.mail),
                SizedBox( height: 20 ),
                Padding(child: Divider( color: Colors.black), padding: EdgeInsets.symmetric(horizontal: 10)),
                SizedBox( height: 10 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DataText(dataLabel: "N° DUVIDAS", dataValue: "${this.usuario.nmrDuvidas}"),
                    DataText(dataLabel: "N° RESPOSTAS ", dataValue: "${this.usuario.nmrRespostas}"),
                    DataText(dataLabel: "PONTUAÇÃO", dataValue: "${this.usuario.pontos} XP"),
                  ],
                ),
                SizedBox( height: 10 ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DataText(dataLabel: "N° RESOLUÇÕES", dataValue: "${this.usuario.nmrResolucoes}"),
                  ],
                ),
                Padding(child: Divider( color: Colors.black), padding: EdgeInsets.symmetric(horizontal: 10)),
                SizedBox(
                  height: 200,
                  child: this.widget.editable == true ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric( horizontal: 10 ),
                        child: CustomButton(
                          label: "EDITAR",
                          action: (){
                            Navigator.push( context, MaterialPageRoute(builder: (context) => EditarUsuario(usuario: this.usuario)) );
                          },
                        ),
                      )
                    ],
                  ) : null
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}



