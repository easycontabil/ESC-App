import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractService{
  Encoding encoding;
  String prefix, host, path, token, queryPath;

  AbstractService({ this.prefix = "http://", @required this.host, this.path, this.queryPath, Encoding encoding }) : this.encoding = encoding ?? Encoding.getByName('utf-8') ;

  Uri buildUri([ String extraParams ]){
    String baseUrl = "${this.prefix}${this.host}";

    if (this.path != null) baseUrl += "/${this.path}";
    if (extraParams != null) baseUrl += "/${extraParams}";
    if (queryPath != null) baseUrl += "?${this.queryPath}";

    return Uri.parse(baseUrl);
  }

  Future<Map<String, String>> getHeader({ bool auth = false }) async {
    if( auth == true){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return { "Content-Type": "application/json; charset=utf-8", "Authorization": "Bearer ${prefs.get('token')}"};
    }
    return { "Content-Type": "application/json; charset=utf-8" };
  }

  Future<Map<String, String>> getAuthHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.get('token'));
    return { "Authorization": "Bearer ${prefs.get('token')}"};
  }

  dynamic decode(http.Response response) => json.decode(utf8.decode(response.bodyBytes));

}
