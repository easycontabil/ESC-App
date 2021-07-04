import 'package:easycontab/models/Abstract.dart';
// import 'package:easycontab/models/Usuario.dart';

class Comentario extends Abstract{
  int duvidaId;
  String usuario;
  String comentario;

  Comentario({id, criacao, this.comentario, this.duvidaId, this.usuario}) : super(id: id, criacao: criacao);

  Comentario.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.criacao = json['createdAt'];
    this.duvidaId = json['doubtId'];
    this.comentario = json['content'];
    this.usuario = json['userId'];
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'createdAt': this.criacao ,
    'doubtId': this.duvidaId,
    'content': this.comentario,
    'userId': this.usuario
  };

  @override 
  String toString() => "@${this.usuario} comentário.";
}
