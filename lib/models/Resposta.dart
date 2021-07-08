import 'package:easycontab/models/Comentario.dart';
import 'package:easycontab/models/Reacao.dart';

import 'Abstract.dart';
import 'Duvida.dart';
import 'Usuario.dart';

class Resposta extends Abstract{
  Usuario usuario;
  Duvida duvida;
  List<Comentario> comentarios;
  List<ReacaoResposta> reacoes;
  String conteudo;
  bool resolveu;
  int nrAprovacoes, nrDesaprovacoes, nrComentarions;
  bool reacaoResposta;

  Resposta(
    { id, criacao, ultimaModificacao, this.usuario, this.duvida, this.conteudo, this.nrAprovacoes, this.nrDesaprovacoes, this.resolveu }
  ) : super(id: id, criacao: criacao, ultimaModificacao: ultimaModificacao);

  Resposta.fromJson(Map<String, dynamic> json, { bool loadDependencies = false }){
    this.id = json['id'];
    this.criacao = DateTime.parse(json['createdAt']);
    this.ultimaModificacao = DateTime.parse(json['updatedAt']);
    this.usuario = Usuario.fromJson(json['user']);
    this.duvida = Duvida(id: json['doubtId']);
    this.conteudo = json['content'];
    this.resolveu = json['solved'];
    if (loadDependencies == true) {
      this.comentarios = comentariosFromJson(json['comments']);
      this.reacoes = reacoesFromJson(json['answerReactions']);
      this.nrComentarions = this.comentarios.length;
      this.nrAprovacoes = this.reacoes.where((element) => element.curtiu == true).toList().length;
      this.nrDesaprovacoes = this.reacoes.where((element) => element.curtiu == false).toList().length;
    }
  } 

  List<Comentario> comentariosFromJson(dynamic json){
      List<Comentario> comentarios = [];

      for( var comentario in json){
        comentarios.add( Comentario.fromJson(comentario) );
      }
      return comentarios;
    }

    List<ReacaoResposta> reacoesFromJson(dynamic json){
      List<ReacaoResposta> reacoes = [];

      for( var reacao in json){
        reacoes.add( ReacaoResposta.fromJson(reacao) );
      }
      return reacoes;
    }

  Map<String, dynamic> toJson() {
    if (this.reacaoResposta != null) {
      return {
        'answerReaction': {
          'liked': this.reacaoResposta
        }
      };
    }

    return {
      'doubtId': this.duvida.id,
      'content': this.conteudo,
      'solved': this.resolveu
    };
  }

  @override 
  String toString() => this.conteudo;
}
