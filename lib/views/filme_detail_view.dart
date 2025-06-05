import 'package:flutter/material.dart';
import '../models/filme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilmeDetailView extends StatelessWidget {
  final Filme filme;

  const FilmeDetailView({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(filme.titulo)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              filme.urlImagem.isNotEmpty
                  ? Image.network(
                    filme.urlImagem,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                  )
                  : const Icon(Icons.image_not_supported, size: 100),
              const SizedBox(height: 16),
              Text(
                'Título: ${filme.titulo}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Gênero: ${filme.genero}'),
              Text('Faixa Etária: ${filme.faixaEtaria}'),
              Text('Duração: ${filme.duracao} min'),
              Text('Ano: ${filme.ano}'),
              const SizedBox(height: 16),
              const Text(
                'Descrição:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(filme.descricao),
              const SizedBox(height: 16),
              const Text(
                'Pontuação:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              RatingBarIndicator(
                rating: filme.pontuacao,
                itemBuilder:
                    (context, _) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
