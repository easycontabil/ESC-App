import 'package:easycontab/components/Button.dart';
import 'package:easycontab/components/CustomTextField.dart';
import 'package:easycontab/components/FeedAppBar.dart';
import 'package:easycontab/components/SearchTextField.dart';
import 'package:easycontab/components/misc/DrawerActionItem.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/screen/Duvida.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:easycontab/services/RespostaService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Duvidas.dart';

class CriarResposta extends StatelessWidget {
  RespostaService service = new RespostaService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst , path: "qst/answers");

  TextEditingController tituloController = new TextEditingController();
  TextEditingController conteudoController = new TextEditingController();

  Duvida duvida;

  CriarResposta(duvida) {
    this.duvida = duvida;
  }

  void submit(context) async {
    Resposta resposta = new Resposta();

    resposta.resolveu = false;
    resposta.duvida = this.duvida;
    resposta.conteudo = this.conteudoController.text;

    await service.registerResposta(resposta);

    Navigator.push(context, MaterialPageRoute(builder: (context) => VerDuvida(duvidaId: this.duvida.id)) );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                      child: Image.asset(
                          Assets.userRegister,
                          height: 80,
                          fit: BoxFit.fill
                      )
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("LOGIN", style: GoogleFonts.openSans( fontSize: 19, color: Colors.grey, fontWeight: FontWeight.w700)),
                    Text("GABRIEL ANDRADE", style: GoogleFonts.openSans( fontSize: 21, color: Colors.grey[350], fontWeight: FontWeight.w600)),
                  ],
                )
              ],
            ),
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "PERFIL",
            action: (){},
            icon: Icons.person,
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "DÚVIDAS",
            action: (){},
            icon: Icons.question_answer,
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "NOTIFICAÇÕES",
            action: (){},
            icon: Icons.notifications,
          ),
          Divider( color: Colors.grey[300], height: 4),
          DrawerActionItem(
            title: "MINHAS DÚVIDAS",
            action: (){},
            icon: Icons.question_answer,
          ),
          Divider( color: Colors.grey[300], height: 4),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(241,237,237, 1),
      drawer: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.grey[900].withOpacity(0.9)
          ),
          child: Container(
            width: size.width * 0.9,
            child: Drawer(
              child: getDrawerActions(),
            ),
          )
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  color: Color.fromRGBO(241,237,237, 1),
                  height: 190, width: size.width,
                ),
                Positioned(child: FeedAppBar(logged: true, height: 150,), top: 0),
                SearchField(labelText: "BUSCAR", margin: EdgeInsets.only(top: 10, bottom: 10, left: 40, right: 40)),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only( left: 20, top: 6, right: 20, bottom: 6),
              padding: EdgeInsets.only( left: 10, top: 4, right: 10, bottom: 4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Container(
                          child: Column(
                            children: [
                              CustomTextField(labelText: "RESPOSTA", textController: this.conteudoController),
                              SizedBox(height: 40),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomSmallButton(
                                    action: (){
                                      Navigator.pop(context);
                                    },
                                    label: "CANCELAR",
                                    color: Color.fromRGBO(229,64,64,1),
                                  ),
                                  CustomSmallButton(
                                    action: (){
                                      submit(context);
                                    },
                                    label: "CRIAR",
                                  ),
                                ],
                              ),
                              SizedBox(height: 40),
                            ],
                          )
                      ),
                    ),
                  ]
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
            )
          ],
        ),
      ),
    );
  }
}
