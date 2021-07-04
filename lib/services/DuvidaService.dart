import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:easycontab/models/Duvida.dart';
import 'AbstractService.dart';

class DuvidaService extends AbstractService {

  DuvidaService({ encoding, prefix, @required host, path, queryParams}) 
  : super( prefix: prefix, host: host, path: path, queryParams: queryParams, encoding: encoding );

  // POST
  Future<Duvida> registerDuvida(Duvida duvida) async {
    http.Response response = await http.post(
      this.buildUri(),
      body: json.encode(duvida.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Duvida.fromJson(this.decode(response)["data"]);
  }

  // PUT
  Future<Duvida> updateDuvida({String id, Duvida duvida}) async {
    http.Response response = await http.put(
      this.buildUri(id.toString()),
      body: json.encode(duvida.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Duvida.fromJson(this.decode(response)["data"]);
  }

  // GET
  Future<Duvida> getDuvida(String id, { bool loadDependencies = false }) async{
    http.Response response = await http.get(this.buildUri(id.toString()), headers: await this.getHeader(auth: true));

    return Duvida.fromJson(this.decode(response)["data"], loadDependencies: loadDependencies);
  }

  // LIST
  Future<List<Duvida>> getDuvidas({ bool loadDependencies = false }) async {
    List<Duvida> duvidas = new List<Duvida>();

    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));

    for (var obj in this.decode(response)["data"]["data"]) {
      duvidas.add(Duvida.fromJson(obj, loadDependencies: loadDependencies) );
    }

    return duvidas;
  }
}
