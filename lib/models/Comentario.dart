import 'package:easycontab/models/Abstract.dart';
import 'package:easycontab/models/Resposta.dart';
import 'package:easycontab/models/Usuario.dart';

import 'Duvida.dart';

class Comentario extends Abstract{
  Resposta resposta;
  Usuario usuario;
  String comentario;

  Comentario({id, criacao, this.comentario, this.resposta, this.usuario}) : super(id: id, criacao: criacao);

  Comentario.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.criacao = DateTime.parse(json['createdAt']) ?? null;
    this.resposta = Resposta(id: json['answerId']);
    this.comentario = json['content'];
    this.usuario = json['user'] != null ? Usuario.fromJson(json['user']) : new Usuario( id: json['userId'] );
  }

  Map<String, dynamic> toJson() => {
    'answerId': this.resposta.id,
    'content': this.comentario,
  };

  @override 
  String toString() => "@${this.usuario.nome} comentário.";
}
