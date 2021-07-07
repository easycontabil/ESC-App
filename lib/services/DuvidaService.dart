import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:easycontab/models/Duvida.dart';
import 'AbstractService.dart';

class DuvidaService extends AbstractService {

  DuvidaService({ encoding, prefix, @required host, path, queryPath}) 
  : super( prefix: prefix, host: host, path: path, queryPath: queryPath, encoding: encoding );

  // POST
  Future<Duvida> registerDuvida(Duvida duvida, [ String extraParams ]) async {
    http.Response response = await http.post(
      this.buildUri(extraParams),
      body: json.encode(duvida.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Duvida.fromJson(this.decode(response)["data"]);
  }

  // PUT
  Future<Duvida> updateDuvida({String id, Duvida duvida, String extraParams}) async {
    http.Response response = await http.put(
      this.buildUri(extraParams),
      body: json.encode(duvida.toJson()),
      headers: await this.getHeader(auth: true),
      encoding: this.encoding
    );

    return Duvida.fromJson(this.decode(response)["data"]);
  }

  // GET
  Future<Duvida> getDuvida(String id, { bool loadDependencies = false, String extraParams }) async{
    http.Response response = await http.get(this.buildUri(id), headers: await this.getHeader(auth: true));

    return Duvida.fromJson(this.decode(response)["data"], loadDependencies: loadDependencies);
  }

  // LIST
  Future<List<Duvida>> getDuvidas({ bool loadDependencies = false, String extraParams }) async {
    List<Duvida> duvidas = [];

    http.Response response = await http.get(this.buildUri(extraParams), headers: await this.getHeader(auth: true));

    for (var obj in this.decode(response)["data"]["data"]) {
      duvidas.add(Duvida.fromJson(obj, loadDependencies: loadDependencies) );
    }

    return duvidas;
  }
}
