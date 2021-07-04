import 'package:easycontab/models/Categoria.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'AbstractService.dart';

class CategoriaService extends AbstractService {

  CategoriaService({ encoding, prefix, @required host, path, queryParams}) 
  : super( prefix: prefix, host: host, path: path, queryParams: queryParams, encoding: encoding );

  Future<Categoria> getCategoria(String id) async {
    http.Response response = await http.get(this.buildUri(id.toString()), headers: await this.getHeader(auth: true));

    return Categoria.fromJson(this.decode(response)["data"]);
  }

  Future<List<Categoria>> getCategorias() async {
    List<Categoria> categorias = new List<Categoria>();
    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));

    for( var obj in this.decode(response)["data"]["data"]) {
      categorias.add(Categoria.fromJson(obj));
    }

    return categorias;
  }
}
