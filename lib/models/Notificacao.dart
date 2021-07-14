import 'Abstract.dart';
import 'Usuario.dart';

class Notificacao extends Abstract{
  Usuario usuario;
  String usuarioId;
  String titulo, conteudo, tipo;

  Notificacao( 
    { id, criacao, this.usuario, this.usuarioId, this.titulo, this.conteudo, this.tipo }
  ) : super(id: id, criacao: criacao);

  Notificacao.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.usuarioId = json['userId'];
    this.titulo = json['title'];
    this.conteudo = json['content'];
    this.tipo = json['type'];
    this.criacao = DateTime.parse(json['createdAt']) ?? null;
  }

  Map<String, dynamic> tojson() => {
    'id': this.id,
    'usuario_id': this.usuarioId,
    'titulo': this.titulo,
    'conteudo': this.conteudo,
    'tipo': this.tipo,
    'criacao': this.criacao
  };

  @override
  String toString() => this.titulo;

}