import 'package:easycontab/models/PalavraChave.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'AbstractService.dart';

class PalavraChaveService extends AbstractService{

  PalavraChaveService({ encoding, prefix, @required host, path, queryPath}) 
  : super( prefix: prefix, host: host, path: path, queryPath: queryPath, encoding: encoding );

  Future<PalavraChave> getPalavraChave(String id) async {
    http.Response response = await http.get(this.buildUri(id), headers: await this.getHeader(auth: true));

    return PalavraChave.fromJson(this.decode(response)["data"]);
  }

  Future<List<PalavraChave>> getPalavrasChaves() async {
    List<PalavraChave> palavrasChave = new List<PalavraChave>();

    http.Response response = await http.get(this.buildUri(), headers: await this.getHeader(auth: true));

    for( var obj in this.decode(response)["data"]["data"]){
      palavrasChave.add(PalavraChave.fromJson(obj));
    }

    return palavrasChave;
  }
}
