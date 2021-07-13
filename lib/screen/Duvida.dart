
import 'package:easycontab/components/CustomDrawer.dart';
import 'package:easycontab/components/DuvidaText.dart';
import 'package:easycontab/components/FeedAppBar.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Duvida.dart';
import 'package:easycontab/services/DuvidaService.dart';
import 'package:flutter/material.dart';

import 'CriarResposta.dart';

class VerDuvida extends StatefulWidget {
  final String duvidaId;

  VerDuvida({ @required this.duvidaId });

  @override
  _VerDuvidaState createState() => _VerDuvidaState(duvidaId);
}

class _VerDuvidaState extends State<VerDuvida> {

  DuvidaService service = new DuvidaService(
    prefix: ApiUrls.prefix, 
    host: ApiUrls.hostqst , 
    path: "qst/doubts",
  );

  bool respostas = false;
  Duvida duvida;

  void getDuvida(String id) {
    this.service.getDuvida(id, loadDependencies: true).then((response) => {
      setState(() {
        duvida = response;
      })
    });
  }

  _VerDuvidaState(String id) {
    this.service.queryPath = "*deletedAt=null&_doubtReactions=[]&_user=[]";
    getDuvida(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(241,237,237, 1),
        drawer: CustomDrawer(),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                FeedAppBar(logged: true, height: 150,),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                      children: [
                        this.duvida != null ? DuvidaText(duvida: this.duvida) : Center( child: CircularProgressIndicator(), )                       
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push( context, MaterialPageRoute(builder: (context) => CriarResposta(this.duvida)) );
          },
        )
    );
  }
}

