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
    final map = {
      'urlImagem': urlImagem,
      'titulo': titulo,
      'genero': genero,
      'faixaEtaria': faixaEtaria,
      'duracao': duracao,
      'pontuacao': pontuacao,
      'descricao': descricao,
      'ano': ano,
    };

    if (id != null) {
      map['id'] = id!;
    }

    return map;
  }

  // Criar Filme a partir de Map (do banco de dados)
  factory Filme.fromMap(Map<String, dynamic> map) {
    return Filme(
      id:
          map['id'] is int
              ? map['id'] as int
              : int.tryParse(map['id'].toString()),
      urlImagem: map['urlImagem'] as String,
      titulo: map['titulo'] as String,
      genero: map['genero'] as String,
      faixaEtaria: map['faixaEtaria'] as String,
      duracao:
          map['duracao'] is int
              ? map['duracao'] as int
              : int.tryParse(map['duracao'].toString()) ?? 0,
      pontuacao:
          map['pontuacao'] is int
              ? (map['pontuacao'] as int).toDouble()
              : (map['pontuacao'] as double),
      descricao: map['descricao'] as String,
      ano:
          map['ano'] is int
              ? map['ano'] as int
              : int.tryParse(map['ano'].toString()) ?? 0,
    );
  }
}
