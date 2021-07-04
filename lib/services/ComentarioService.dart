import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:easycontab/models/Comentario.dart';
import 'AbstractService.dart';

class ComentarioService extends AbstractService {

  ComentarioService({ encoding, prefix, @required host, path, queryParams}) 
  : super(prefix: prefix, host: host, path: path, queryParams: queryParams, encoding: encoding);

  // POST
  Future<Comentario> registerComentario(Comentario comentario) async {
    http.Response response = await http.post(
      this.buildUri(),
      body: json.encode(comentario.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Comentario.fromJson(this.decode(response)["data"]);
  }

  // PUT
  Future<Comentario> updateComentario({String id, Comentario comentario}) async {
    http.Response response = await http.put(
      this.buildUri(id.toString()),
      body: json.encode(comentario.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Comentario.fromJson(this.decode(response)["data"]);
  }

  // GET
  Future<Comentario> getComentario(String id) async{
    http.Response response = await http.get(this.buildUri(id.toString()), headers: await this.getHeader(auth: true));

    return Comentario.fromJson(this.decode(response)["data"]);
  }

  // LIST
  Future<List<Comentario>> getComentarios() async{
    List<Comentario> comentarios = new List<Comentario>();

    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));

    for( var obj in this.decode(response)["data"]["data"]){
      comentarios.add(Comentario.fromJson(obj));
    }

    return comentarios;
  }

}
