import 'package:easycontab/components/ComentarioComponent.dart';
import 'package:easycontab/components/CustomDrawer.dart';
import 'package:easycontab/components/DuvidaText.dart';
import 'package:easycontab/components/FeedAppBar.dart';
import 'package:easycontab/components/RespostaComponent.dart';
import 'package:easycontab/components/misc/DrawerActionItem.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/contants/app_assets.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VerDuvida extends StatefulWidget {
  String duvidaId;

  VerDuvida(String id) {
    duvidaId = id;
  }

  @override
  _VerDuvidaState createState() => _VerDuvidaState(duvidaId);
}

class _VerDuvidaState extends State<VerDuvida> {
  DuvidaService service = new DuvidaService(prefix: ApiUrls.prefix, host: ApiUrls.hostqst , path: "qst/doubts");

  Duvida duvida = new Duvida();

  getDuvida(String id) {
    this.service.getDuvida(id).then((response) => {
      setState(() {
        duvida = response;
      })
    });
  }

  _VerDuvidaState(String id) {
    getDuvida(id);
  }

  // TODO Ver com gabriel para criar um componente que renderize a duvida com todas as respostas e comentarios
  listaDuvida() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241,237,237, 1),
        drawer: CustomDrawer(),
        body: Container(
          child: Column(
            children: [
              FeedAppBar(logged: true, height: 150,),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    children: [
                      DuvidaText(),
                      RespostaComponent(
                        conteudo: "Nullam ornare sit amet quam ac lacinia. Donec egestas ligula id felis luctus, in accumsan tellus tincidunt. Cras mi est, sagittis sed libero ut, congue vehicula enim",
                        nrComentarios: 2,
                        nrCurtidas: 2,
                        nrDescurtidas: 0,
                        resolveu: false,
                      ),
                      RespostaComponent(
                        conteudo: "Nullam ornare sit amet quam ac lacinia. Donec egestas ligula id felis luctus, in accumsan tellus tincidunt. Cras mi est, sagittis sed libero ut, congue vehicula enim",
                        nrComentarios: 2,
                        nrCurtidas: 2,
                        nrDescurtidas: 0,
                        resolveu: false,
                      ),
                      ComentarioComponent(conteudo: "Nullam ornare sit amet quam ac lacinia. Donec egestas ligula id felis luctus",)
                    ]
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: (){},
        )
    );
  }
}

