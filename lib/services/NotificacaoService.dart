import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:easycontab/models/Notificacao.dart';
import 'AbstractService.dart';

class NotificacaoService extends AbstractService {

  NotificacaoService({ encoding, prefix, @required host, path, queryPath}) 
  : super( prefix: prefix, host: host, path: path, queryPath: queryPath, encoding: encoding );

  // GET --> LIST
  Future<List<Notificacao>> getNotificacoes() async {
    List<Notificacao> notificacoes = [];

    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));

    for( var obj in this.decode(response)["data"]["data"]){
      notificacoes.add( Notificacao.fromJson(obj) );
    }

    return notificacoes;
  }
}