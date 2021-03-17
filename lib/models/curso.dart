class Curso {
  final int id;
  final String nome;
  final String descricao;

  Curso(this.id, this.nome,this.descricao);

  @override
  String toString() {
    return 'Curso{nome: $nome, descricao: $descricao}';
  }
}