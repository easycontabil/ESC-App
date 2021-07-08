
import 'Abstract.dart';

class Usuario extends Abstract{
  String nome, login, senha, email, foto;
  bool admin;
  int pontos;

  Usuario(
    {id, this.nome, this.login, this.senha, this.email, this.admin, this.foto, this.pontos}
  ) : super(id: id);

  Usuario.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.nome = json['name'];
    this.login = json['login'];
    this.senha = json['password'];
    this.email = json['email'];
    this.admin = json['admin'];
    this.foto = json['image'];
    this.pontos = json['points'];
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'name': this.nome,
    'login': this.login,
    'password': this.senha,
    'email': this.email,
    'admin': this.admin,
    'image': this.foto,
    'points': this.pontos
  };

  @override
  String toString() => this.nome;
}
