import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/screen/Duvida.dart';
import 'package:easycontab/screen/EditarDuvida.dart';
import 'package:easycontab/screen/Perfil.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:easycontab/utils/shapes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'misc/IconCount.dart';

class DuvidaComponent extends StatefulWidget {

  final Duvida duvida;

  @override
  _DuvidaComponentState createState() => _DuvidaComponentState();

  DuvidaComponent({ @required this.duvida });
}

class _DuvidaComponentState extends State<DuvidaComponent> {
  Usuario usuario = new Usuario();

  Preferences preferences = new Preferences();

  setUser() {
    this.preferences.init().then((value) => {
      setState(() {
        this.usuario = this.preferences.getUser();
      })
    });
  }

  _DuvidaComponentState() {
    setUser();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        Navigator.push( context, MaterialPageRoute(builder: (context) => VerDuvida(duvidaId: this.widget.duvida.id ) ) );
      },
      child: Padding(
        padding: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
        child: Container(
          padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [              
                  CustomPaint(size: Size(21,14), painter: DrawTriangle(color: this.widget.duvida.relevancia > 0 ? Colors.green : Colors.grey)),
                  SizedBox(height: 5,),
                  Text(this.widget.duvida.relevancia.toString(), style: GoogleFonts.openSans( fontSize: 14, fontWeight: FontWeight.w600 ) ),
                  SizedBox(height: 5,),
                  CustomPaint(size: Size(21,14), painter: DrawInverseTriangle(color: this.widget.duvida.relevancia < 0 ? Colors.red : Colors.grey)),
                ]
              ),
              GestureDetector(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: this.widget.duvida.usuario.foto != null ? Image.network(this.widget.duvida.usuario.foto, width: 25, height: 25, fit: BoxFit.fitWidth) : Image.asset(Assets.avatar, width: 25, height: 25, fit: BoxFit.fitWidth)          
                    ),
                    // this.widget.duvida.usuario.foto != null ? Image.network(this.widget.duvida.usuario.foto, width: 25, height: 25, fit: BoxFit.fitWidth) : Image.asset(Assets.avatar, width: 25, height: 25, fit: BoxFit.fitWidth)
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
                          child: Text(this.widget.duvida.titulo, overflow: TextOverflow.ellipsis, style: GoogleFonts.openSans( color: Color.fromRGBO(78,76,76,1), fontSize: 12, fontWeight: FontWeight.w600),),
                        ),
                        Container(
                          width: size.width * 0.70,
                          child: Text(
                            this.widget.duvida.descricao, 
                            style: GoogleFonts.openSans( color: Color.fromRGBO(161,161,161,1), fontSize: 9, fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(                 
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconCount(count: this.widget.duvida.nrRespostas ?? 0, icon: Icons.messenger_sharp, size: 18, ),
                      Icon(Icons.check, color: this.widget.duvida.resolvida == true ? Colors.green : Colors.grey ),
                      this.usuario.id == this.widget.duvida.usuario.id ? GestureDetector(
                        child: IconCount(icon: Icons.edit),
                        onTap: () {
                          Navigator.push( context, MaterialPageRoute(builder: (context) => EditarDuvida(duvida: this.widget.duvida)) );
                        },
                      ) : Text("")
                    ],
                  ),
                ]
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: this.widget.duvida.aberta == true ? Colors.white : Colors.grey[300] ,
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
      ),
    );
  }
}
