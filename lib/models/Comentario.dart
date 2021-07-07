import 'package:easycontab/models/Abstract.dart';
import 'package:easycontab/models/Usuario.dart';

import 'Duvida.dart';

class Comentario extends Abstract{
  Duvida duvida;
  Usuario usuario;
  String comentario;

  Comentario({id, criacao, this.comentario, this.duvida, this.usuario}) : super(id: id, criacao: criacao);

  Comentario.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.criacao = DateTime.parse(json['createdAt']) ?? null;
    this.duvida = Duvida(id: json['doubtId']);
    this.comentario = json['content'];
    this.usuario = Usuario.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'createdAt': this.criacao,
    'doubtId': this.duvida.id,
    'content': this.comentario,
    // 'userId': this.usuario
  };

  @override 
  String toString() => "@${this.usuario.nome} comentário.";
}
