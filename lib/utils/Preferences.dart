import 'package:easycontab/models/Usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Preferences{
  SharedPreferences _prefs;

  Future<void> init() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  void setToken(String token){
    this._prefs.setString("token", token);
  }

  String getToken(){
    return this._prefs.get("token");
  }

  Usuario getUser(){
    return Usuario.fromJson(JwtDecoder.decode(this.getToken()));
  }
}