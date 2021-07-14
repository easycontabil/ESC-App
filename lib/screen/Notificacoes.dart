
import 'package:easycontab/components/BackgroundBaseWidget.dart';
import 'package:easycontab/components/NotificacaoComponent.dart';
import 'package:easycontab/contants/app_api_urls.dart';
import 'package:easycontab/models/Notificacao.dart';
import 'package:easycontab/models/Usuario.dart';
import 'package:easycontab/services/NotificacaoService.dart';
import 'package:easycontab/utils/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notificacoes extends StatefulWidget {
  Usuario usuario;

  Notificacoes({ this.usuario });

  @override
  _NotificacoesState createState() => _NotificacoesState(usuario);
}

class _NotificacoesState extends State<Notificacoes> {
  NotificacaoService service = new NotificacaoService( prefix: ApiUrls.prefix, host: ApiUrls.hostqst , path: "qst/notifications");

  List<NotificacaoComponent> listaNotificacoes(){
    List<NotificacaoComponent> notificacoes = [];

    for (var notificacao in this.notificacoes) {
      notificacoes.add(NotificacaoComponent(notificacao: notificacao));
    }

    return notificacoes;
  }

  List<Notificacao> notificacoes = [];

  getNotificacoes(usuario) {
    this.service.queryPath = "*deletedAt=null&*userId=${usuario.id}";

    this.service.getNotificacoes().then((response) => {
      setState(() {
        notificacoes = response;
      })
    });
  }

  _NotificacoesState(Usuario usuario) {
    getNotificacoes(usuario);
  }

  List<Widget> getContent(){
    List<Widget> widgets = [];

    widgets.add(
      Padding(
        padding: EdgeInsets.only( left: 12, top: 12, bottom: 30),
        child: FloatingActionButton(onPressed: (){ Navigator.pop(context); }, backgroundColor: Colors.white, child: Icon(Icons.arrow_back, color: Colors.black))
      )  
    );
    widgets.addAll(this.listaNotificacoes());

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundBaseWidget(     
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.getContent()
      )
    );
  }
}