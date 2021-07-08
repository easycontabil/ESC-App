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
  int nrRespostas, nrViews, nrFavoritos, nrAprovacoes, nrDesaprovacoes;
  bool aberta, resolvida;
  
    Duvida(
      { id, this.titulo, this.descricao, this.usuario, this.categorias, this.nrFavoritos, this.nrAprovacoes, this.nrDesaprovacoes, this.nrRespostas, this.nrViews, this.aberta, this.resolvida }
    ) : super(id: id);
  
    Duvida.fromJson( Map<String, dynamic> json, { bool loadDependencies = false}){
      this.id = json['id'];
      this.criacao = DateTime.parse(json['createdAt']) ?? null;
      this.ultimaModificacao = DateTime.parse(json['updatedAt']) ?? null;
      this.usuario = Usuario.fromJson(json['user']);
      this.titulo = json['title'];
      this.descricao = json['description'];
      this.aberta = json['solved'];
      this.resolvida = json['solved'];
      if( loadDependencies == true){
        this.comentarios = comentariosFromJson(json['comments'], loadDependencies: loadDependencies);
        this.respostas = respostasFromJson(json['answers'], loadDependencies: loadDependencies);
        this.reacoes = reacoesFromJson(json['doubtReactions'], loadDependencies: loadDependencies);
        this.nrRespostas = this.respostas.length;
        this.nrAprovacoes = this.reacoes.where((element) => element.curtiu == true).toList().length;
        this.nrDesaprovacoes = this.reacoes.where((element) => element.curtiu == false).toList().length;
      }
    }

    List<Categoria> categoriasFromJson(dynamic json, { bool loadDependencies = false}){
      List<Categoria> categorias = [];

      for( var categoria in json){
        categorias.add( Categoria.fromJson(categoria) );
      }
      return categorias;
    }

    List<Comentario> comentariosFromJson(dynamic json, { bool loadDependencies = false}){
      List<Comentario> comentarios = [];

      for( var comentario in json){
        comentarios.add( Comentario.fromJson(comentario) );
      }
      return comentarios;
    }

    List<Resposta> respostasFromJson(dynamic json, { bool loadDependencies = false}){
      List<Resposta> respostas = [];

      for( var resposta in json){
        respostas.add( Resposta.fromJson(resposta, loadDependencies: loadDependencies) );
      }
      return respostas;
    }

    List<ReacaoDuvida> reacoesFromJson(dynamic json, { bool loadDependencies = false}){
      List<ReacaoDuvida> reacoes = [];

      for( var resposta in json){
        reacoes.add( ReacaoDuvida.fromJson(resposta) );
      }
      return reacoes;
    }

    Map<String, dynamic> toJson() => {
      'id': this.id,
      'title': this.titulo,
      'description': this.descricao,
      'closedAt': this.aberta ,
      'solved': this.resolvida ,
      'categories': this.gategoriasToJson(),
    };
  
    List<Map<String, dynamic>> gategoriasToJson(){
      List<Map<String, dynamic>> categorias = [];
      this.categorias.forEach((Categoria categoria) {
        categorias.add(categoria.toJson());
      });
      return categorias;
    }
  
    @override 
    String toString() => "${this.titulo}"; 
  
}
  
