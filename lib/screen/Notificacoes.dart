
import 'package:easycontab/components/BackgroundBaseWidget.dart';
import 'package:easycontab/components/NotificacaoComponent.dart';
import 'package:easycontab/models/Notificacao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Notificacoes extends StatefulWidget {

  Notificacoes();

  @override
  _NotificacoesState createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  
  
  List<NotificacaoComponent> getNotificacoes(){
    List<NotificacaoComponent> notificacoes = [];
    notificacoes.add( NotificacaoComponent(notificacao: new Notificacao( titulo: "Titulo", conteudo: "Conteúdo da notificação" )));
    notificacoes.add( NotificacaoComponent(notificacao: new Notificacao( titulo: "Titulo", conteudo: "Conteúdo da notificação" )));
    notificacoes.add( NotificacaoComponent(notificacao: new Notificacao( titulo: "Titulo", conteudo: "Conteúdo da notificação" )));
    notificacoes.add( NotificacaoComponent(notificacao: new Notificacao( titulo: "Titulo", conteudo: "Conteúdo da notificação" )));
    notificacoes.add( NotificacaoComponent(notificacao: new Notificacao( titulo: "Titulo", conteudo: "Conteúdo da notificação" )));
    notificacoes.add( NotificacaoComponent(notificacao: new Notificacao( titulo: "Titulo", conteudo: "Conteúdo da notificação" )));
    return notificacoes;
  }

  List<Widget> getContent(){
    List<Widget> widgets = [];

    widgets.add(
      Padding(
        padding: EdgeInsets.only( left: 12, top: 12, bottom: 30),
        child: FloatingActionButton(onPressed: (){ Navigator.pop(context); }, backgroundColor: Colors.white, child: Icon(Icons.arrow_back, color: Colors.black))
      )  
    );
    widgets.addAll(this.getNotificacoes());

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