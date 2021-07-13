import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/Duvidas.dart';
import 'package:easycontab/screen/MinhasDuvidas.dart';
import 'package:easycontab/screen/PaginaLogin.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'misc/DrawerActionItem.dart';


class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  Usuario usuario = new Usuario();
  Preferences preferences = new Preferences();

  setUser() {
    this.preferences.init().then((value) => {
      setState(() {
        this.usuario = this.preferences.getUser();
      })
    });
  }

  _CustomDrawerState() {
    setUser();
  }

  @override
  Widget build(BuildContext context) {
    ListView getDrawerActions(){
      return ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(Assets.avatar, height: 80, fit: BoxFit.fill )
                      //Image.network(this.usuario.foto, height: 80, fit: BoxFit.fill),                
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(this.usuario.email, style: GoogleFonts.openSans( fontSize: 19, color: Colors.grey, fontWeight: FontWeight.w700)),
                    Text(this.usuario.nome, style: GoogleFonts.openSans( fontSize: 21, color: Colors.grey[350], fontWeight: FontWeight.w600)),
                  ],
                )
              ],
            ),
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "PERFIL",
            action: (){
              Navigator.push( context, MaterialPageRoute(builder: (context) => Perfil()) );
            },
            icon: Icons.person,
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "DÚVIDAS",
            action: (){
              Navigator.push( context, MaterialPageRoute(builder: (context) => Duvidas()) );
            },
            icon: Icons.question_answer,
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "NOTIFICAÇÕES",
            action: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => Duvidas()) );
            },
            icon: Icons.notifications,
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "MINHAS DÚVIDAS",
            action: (){
              Navigator.push( context, MaterialPageRoute(builder: (context) => MinhasDuvidas(usuario: this.usuario)) );
            },
            icon: Icons.question_answer,
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "Início",
            action: (){
              Navigator.push( context, MaterialPageRoute(builder: (context) => PaginaLogin()) );
            },
            icon: Icons.input_rounded,
          ),
          Divider( color: Colors.grey[300], height: 4),
        ],
      );
    }

    Size size = MediaQuery.of(context).size;

    return Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.grey[900].withOpacity(0.9)
        ),
        child: Container(
          width: size.width * 0.9,
          child: Drawer(
            child: getDrawerActions(),
          ),
        )
    );
  }
}
