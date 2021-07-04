import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:easycontab/models/Usuario.dart';
import 'AbstractService.dart';

class UsuarioService extends AbstractService {

  UsuarioService({ encoding, prefix, @required host, path, queryParams}) 
  : super( prefix: prefix, host: host, path: path, queryParams: queryParams, encoding: encoding );

  // POST
  Future<Usuario> registerUsuario(Usuario usuario) async {
    http.Response response = await http.post(
      this.buildUri(),
      body: json.encode(usuario.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Usuario.fromJson(this.decode(response)["data"]);
  }

  // PUT
  Future<Usuario> updateUsuario({String id, Usuario usuario}) async {
    http.Response response = await http.put(
      this.buildUri(id),
      body: json.encode(usuario.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Usuario.fromJson(this.decode(response)["data"]);
  }

  // GET
  Future<Usuario> getUsuario(String id) async{
    http.Response response = await http.get(this.buildUri(id), headers: await this.getHeader(auth: true));

    return Usuario.fromJson(this.decode(response)["data"]);
  }

  // LIST
  Future<List<Usuario>> getUsuarios() async{
    List<Usuario> usuarios = new List<Usuario>();

    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));

    for (var obj in this.decode(response)["data"]["data"]){
      usuarios.add(Usuario.fromJson(obj));
    }

    return usuarios;
  }
}
