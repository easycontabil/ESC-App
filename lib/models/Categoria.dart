import 'Abstract.dart';

class Categoria extends Abstract{
  String nome, descricacao;

  Categoria(
    { id, this.nome, this.descricacao }
  ) : super(id: id);

  Categoria.fromJson( Map<String, dynamic> json ) {
    this.id = json['id'];
    this.nome = json['name'];
    this.descricacao = json['description'];
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'name': this.nome,
    'description': this.descricacao,
  };

  @override
  String toString() => this.nome;
}
