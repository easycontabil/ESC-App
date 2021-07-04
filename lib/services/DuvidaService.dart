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
    dynamic headers = await this.getHeader(auth: true);

    http.Response response = await http.post(
      this.buildUri(),
      body: json.encode(duvida.toJson()),
      headers: headers,
      encoding: this.encoding
    );

    return Duvida.fromJson(this.decode(response));
  }

  // PUT
  Future<Duvida> updateDuvida({int id, Duvida duvida}) async {

    dynamic headers = await this.getHeader(auth: true);

    http.Response response = await http.put(
      this.buildUri(id.toString()),
      body: json.encode(duvida.toJson()),
      headers: headers,
      encoding: this.encoding
    );

    return Duvida.fromJson(this.decode(response));
  }

  // GET
  Future<Duvida> getDuvida(int id, { bool loadDependencies = false }) async{
    dynamic headers = await this.getHeader(auth: true);

    http.Response response = await http.get( this.buildUri(id.toString()), headers: headers );
    
    dynamic json = this.decode(response);
    return Duvida.fromJson(json, loadDependencies: loadDependencies);

  }

  // GET --> LIST
  Future<List<Duvida>> getDuvidas({ bool loadDependencies = false }) async {
    List<Duvida> duvidas = [];

    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));
    dynamic json = this.decode(response);

    for (var obj in json["data"]) {
      duvidas.add(Duvida.fromJson(obj, loadDependencies: loadDependencies) );
    }

    return duvidas;
  }
}