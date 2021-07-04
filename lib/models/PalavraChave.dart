import 'Abstract.dart';

class PalavraChave extends Abstract{
  String nome;

  PalavraChave( 
    { id, this.nome }
  ) : super(id: id);

  PalavraChave.fromJson(Map<String, dynamic> json){
    this.id = json['id'];
    this.nome = json['name'];
  }

  @override 
  String toString() => "${this.nome}";
}
