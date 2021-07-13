
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'AbstractService.dart';
import 'dart:convert';

class AuthService extends AbstractService {

  AuthService({ encoding, prefix, @required host, path, queryPath}) 
  : super( prefix: prefix, host: host, path: path, queryPath: queryPath, encoding: encoding );
  

  // CONFIRM
  Future<Map<String, dynamic>> confirm([ String token ]) async {
    http.Response response = await http.post( 
      this.buildUri("confirm"),
      headers: await this.getHeader(auth: false),
      body: json.encode({ 'token': token })
    );
    dynamic data = this.decode(response);
    return data;
  }

  // LOGIN
  Future<Map<String, dynamic>> login([ String email, String senha ]) async {
    dynamic headers = await this.getHeader(auth: false);

    http.Response response = await http.post( 
      this.buildUri("login"),
      headers: headers,
      body: json.encode({ 'email': email, 'password': senha})
    );
    dynamic data = this.decode(response);
    return data;
  }

  // REGISTER
  Future<Map<String, dynamic>> register([ String login, String email, String senha, String image ]) async {
    dynamic headers = await this.getHeader(auth: false);

    http.Response response = await http.post( 
      this.buildUri("register"),
      headers: headers,
      body: json.encode({ 'name': login, 'email': email, 'password': senha, 'password_confirmation': senha, 'image': image})
    );
    dynamic data = this.decode(response);
    return data;
  }

  // UPDATE
  Future<Map<String, dynamic>> update([ String id, String login, String email, String senha, String image ]) async {
    dynamic headers = await this.getHeader(auth: true);

    print({ 'id': id, 'name': login, 'email': email, 'password': senha, 'password_confirmation': senha});

    http.Response response = await http.put( 
      this.buildUri("users/${id}"),
      headers: headers,
      body: json.encode({'name': login, 'email': email, 'password': senha, 'password_confirmation': senha, 'image': image})
    );
    dynamic data = this.decode(response);
    return data;
  }

}
