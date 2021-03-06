import 'package:easycontab/models/Abstract.dart';

import 'Duvida.dart';
import 'Resposta.dart';
import 'Usuario.dart';

class ReacaoResposta extends Abstract{
  Usuario usuario;
  Resposta resposta;
  bool curtiu;  

  ReacaoResposta({ id, this.usuario, this.resposta, this.curtiu }) : super(id: id);

  ReacaoResposta.fromJson(Map<String, dynamic> json) {
    this.usuario = json['user'] != null ? Usuario.fromJson(json['user']) : new Usuario( id: json['userId'] );
    this.resposta = Resposta(id: json['answerId']);
    this.curtiu = json['liked'];
  }

  Map<String, dynamic> toJson() => {
    'answerReaction': { 'liked': this.curtiu }
  };
}

class ReacaoDuvida extends Abstract{
  Usuario usuario;
  Duvida duvida;
  bool curtiu;  

  ReacaoDuvida({ id, this.usuario, this.duvida, this.curtiu }) : super(id: id);

  ReacaoDuvida.fromJson(Map<String, dynamic> json) {
    this.usuario = Usuario(id:json['userId']); //Usuario.fromJson(json['user']);
    this.duvida = Duvida(id: json['doubtId']);
    this.curtiu = json['liked'];
  }

  Map<String, dynamic> toJson() => {
    'doubtReaction': { 'liked': this.curtiu }
  };
}
