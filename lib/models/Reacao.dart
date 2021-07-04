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
    this.usuario = Usuario(id: json['userId']);
    this.resposta = Resposta(id: json['answerId']);
    this.curtiu = json['liked'];
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'answer': { 'id': this.resposta.id },
    'user': { 'id': this.usuario.id }
  };
}

class ReacaoDuvida extends Abstract{
  Usuario usuario;
  Duvida duvida;
  bool curtiu;  

  ReacaoDuvida({ id, this.usuario, this.duvida, this.curtiu }) : super(id: id);

  ReacaoDuvida.fromJson(Map<String, dynamic> json) {
    this.usuario = Usuario(id: json['userId']);
    this.duvida = Duvida(id: json['doubtId']);
    this.curtiu = json['liked'];
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'doubt': { 'id': this.duvida.id },
    'user': { 'id': this.usuario.id }
  };
}
