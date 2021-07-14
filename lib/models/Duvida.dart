import 'package:easycontab/models/Reacao.dart';

import 'Abstract.dart';
import 'Categoria.dart';
import 'Comentario.dart';
import 'Resposta.dart';
import 'Usuario.dart';

class Duvida extends Abstract{
  Usuario usuario;
  List<Categoria> categorias;
  List<Resposta> respostas;
  List<Comentario> comentarios;
  List<ReacaoDuvida> reacoes;
  String titulo, descricao;
  int nrRespostas, nrViews, nrFavoritos, nrAprovacoes, nrDesaprovacoes, relevancia;
  bool aberta, resolvida;
  bool reacaoDuvida;
  
    Duvida(
      { id, this.titulo, this.descricao, this.usuario, this.categorias, this.nrFavoritos, this.nrAprovacoes, this.nrDesaprovacoes, this.nrRespostas, this.nrViews, this.aberta, this.resolvida }
    ) : super(id: id);
  
    Duvida.fromJson( Map<String, dynamic> json, { bool loadDependencies = false}){
      this.id = json['id'];
      this.criacao = DateTime.parse(json['createdAt']) ?? null;
      this.ultimaModificacao = DateTime.parse(json['updatedAt']) ?? null;
      this.usuario = json['user'] != null ? Usuario.fromJson(json['user']) : Usuario(id: json['userId']);
      this.titulo = json['title'];
      this.descricao = json['description'];
      this.aberta = json['closedAt'] != null ? false : true;
      this.resolvida = json['solved'];
      if (loadDependencies == true) {
        this.respostas = respostasFromJson(json['answers']);
        this.reacoes = reacoesFromJson(json['doubtReactions']);
        this.nrRespostas = this.respostas.length;
        this.nrAprovacoes = this.reacoes.where((element) => element.curtiu == true).toList().length;
        this.nrDesaprovacoes = this.reacoes.where((element) => element.curtiu == false).toList().length;
        this.relevancia = this.nrAprovacoes - this.nrDesaprovacoes;
      }
    }

    List<Categoria> categoriasFromJson(dynamic json) {
      List<Categoria> categorias = [];

      for( var categoria in json){
        categorias.add( Categoria.fromJson(categoria) );
      }
      return categorias;
    }

    List<Comentario> comentariosFromJson(dynamic json) {
      List<Comentario> comentarios = [];

      for( var comentario in json){
        comentarios.add( Comentario.fromJson(comentario) );
      }
      return comentarios;
    }

    List<Resposta> respostasFromJson(dynamic json) {
      List<Resposta> respostas = [];

      for( var resposta in json){
        respostas.add( Resposta.fromJson(resposta, loadDependencies: false) );
      }

      return respostas;
    }

    List<ReacaoDuvida> reacoesFromJson(dynamic json){
      List<ReacaoDuvida> reacoes = [];

      for( var resposta in json){
        reacoes.add( ReacaoDuvida.fromJson(resposta) );
      }
      return reacoes;
    }

    Map<String, dynamic> toJson() {
      if (this.reacaoDuvida != null) {
        return {
          'doubtReaction': {
            'liked': this.reacaoDuvida
          }
        };
      }
      return {
        'categories': this.categorias.map((e) => e.id).toList(),
        'title': this.titulo,
        'description': this.descricao,
      };
    }
  
    @override 
    String toString() => "${this.titulo}"; 
  
}
  
