import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:easycontab/models/Resposta.dart';
import 'AbstractService.dart';

class RespostaService extends AbstractService {

  RespostaService({ encoding, prefix, @required host, path, queryPath}) 
  : super( prefix: prefix, host: host, path: path, queryPath: queryPath, encoding: encoding );

  // POST
  Future<Resposta> registerResposta(Resposta resposta) async {
    http.Response response = await http.post(
      this.buildUri(),
      body: json.encode(resposta.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    // dynamic body = this.decode(response);

    if (response.statusCode == 400) {
      // TODO mostrar algum popUp em tela com a mensagem de erro
      // TODO Criar um solucao global para isso, qualquer erro que der na API tem que renderizar no popUp
      // TODO Seria otimo fica dentro do this.decode
    }

    return Resposta.fromJson(this.decode(response)["data"]);
  }

  // PUT
  Future<Resposta> updateResposta({String id, Resposta resposta}) async {
    http.Response response = await http.put(
      this.buildUri(id.toString()),
      body: json.encode({ 'content': resposta.conteudo }),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Resposta.fromJson(this.decode(response)["data"], loadDependencies: true);
  }

  // PUT
  Future<Resposta> reagirDuvida({String id, Resposta resposta}) async {
    http.Response response = await http.put(
        this.buildUri(id.toString()),
        body: json.encode({ 'answerReaction': {
          'liked': resposta.reacaoResposta
        } }),
        headers: await this.getHeader(auth: true),
        encoding: this.encoding
    );

    return Resposta.fromJson(this.decode(response)["data"], loadDependencies: true);
  }

  // PUT
  Future<Resposta> resolverDuvida({String id, Resposta resposta}) async {
    http.Response response = await http.put(
        this.buildUri(id.toString()),
        body: json.encode({ 'solved': resposta.resolveu }),
        headers: await this.getHeader(auth: true),
        encoding: this.encoding
    );

    return Resposta.fromJson(this.decode(response)["data"], loadDependencies: true);
  }

  // GET
  Future<Resposta> getResposta(String id, { bool loadDependencies = false }) async {
    http.Response response = await http.get(this.buildUri(id.toString()), headers: await this.getHeader(auth: true));

    return Resposta.fromJson(this.decode(response)["data"], loadDependencies: loadDependencies);
  }

  // LIST
  Future<List<Resposta>> getRespostas({bool loadDependencies = false}) async {
    List<Resposta> respostas = [];

    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));

    for (var obj in this.decode(response)["data"]["data"]) {
      respostas.add(Resposta.fromJson(obj, loadDependencies: loadDependencies));
    }

    return respostas;
  }
}
