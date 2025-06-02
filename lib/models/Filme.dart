class Filme {
  int? id;
  late String urlImagem;
  String titulo;
  String genero;
  String faixaEtaria;
  int duracao; // em minutos
  double pontuacao; // de 0 a 5
  String descricao;
  int ano;

  Filme({
    this.id,
    required this.urlImagem,
    required this.titulo,
    required this.genero,
    required this.faixaEtaria,
    required this.duracao,
    required this.pontuacao,
    required this.descricao,
    required this.ano,
  });

  // Converter Filme para Map (para banco de dados)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'urlImagem': urlImagem,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
    };
  }

  // Criar Filme a partir de Map (do banco de dados)
  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id: map['id'],
      urlImagem: map['urlImagem'],
      titulo: map['titulo'],
      genero: map['genero'],
      faixaEtaria: map['faixaEtaria'],
      duracao: map['duracao'],
      pontuacao:
          map['pontuacao'] is int
              ? (map['pontuacao'] as int).toDouble()
              : map['pontuacao'],
      descricao: map['descricao'],
      ano: map['ano'],
    );
  }
}
