import 'package:easycontab/models/Reacao.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'AbstractService.dart';
import 'dart:convert';

class ReacaoDuvidaService extends AbstractService {

  ReacaoDuvidaService({ encoding, prefix, @required host, path, queryPath}) 
  : super( prefix: prefix, host: host, path: path, queryPath: queryPath, encoding: encoding );


  // POST
  Future<ReacaoDuvida> registerReacao(ReacaoDuvida reacao) async {
    http.Response response = await http.post(
      this.buildUri(),
      body: json.encode(reacao.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );
    return ReacaoDuvida.fromJson(this.decode(response));
  }

  // PUT
  Future<ReacaoDuvida> updateReacao(ReacaoDuvida reacao) async {
    http.Response response = await http.post(
      this.buildUri(reacao.id.toString()),
      body: json.encode(reacao.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );
    return ReacaoDuvida.fromJson(this.decode(response));
  }
  
  // GET
  Future<ReacaoDuvida> getReacao(int id) async{
    http.Response response = await http.get( this.buildUri(id.toString()), headers: await this.getHeader(auth: true), );
    
    dynamic json = this.decode(response);
    return ReacaoDuvida.fromJson(json);
  }

  // GET --> LIST
  Future<List<ReacaoDuvida>> getReacoes() async{
    List<ReacaoDuvida> categorias = [];
    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true),);

    dynamic json = this.decode(response);

    for( var obj in json){
      categorias.add( ReacaoDuvida.fromJson(obj) );
    }
    return categorias;
  }

}


class ReacaoRespostaService extends AbstractService {

  ReacaoRespostaService({ encoding, prefix, @required host, path, queryPath}) 
  : super( prefix: prefix, host: host, path: path, queryPath: queryPath, encoding: encoding );


  // POST
  Future<ReacaoResposta> registerReacao(ReacaoResposta reacao) async {
    http.Response response = await http.post(
      this.buildUri(),
      body: json.encode(reacao.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );
    return ReacaoResposta.fromJson(this.decode(response));
  }

  // PUT
  Future<ReacaoResposta> updateReacao(ReacaoResposta reacao) async {
    http.Response response = await http.post(
      this.buildUri(reacao.id.toString()),
      body: json.encode(reacao.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );
    return ReacaoResposta.fromJson(this.decode(response));
  }
  
  // GET
  Future<ReacaoResposta> getReacao(int id) async{
    http.Response response = await http.get( this.buildUri(id.toString()), headers: await this.getHeader(auth: true), );
    
    dynamic json = this.decode(response);
    return ReacaoResposta.fromJson(json);
  }

  // GET --> LIST
  Future<List<ReacaoResposta>> getReacoes() async{
    List<ReacaoResposta> categorias = [];
    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true),);

    dynamic json = this.decode(response);

    for( var obj in json){
      categorias.add( ReacaoResposta.fromJson(obj) );
    }
    return categorias;
  }

}