import 'package:flutter/material.dart';
import '../models/filme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FilmeDetailView extends StatelessWidget {
  final Filme filme;

  FilmeDetailView({required this.filme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(filme.titulo),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Image.network(filme.urlImagem),
            SizedBox(height: 16),
            Text('Título: ${filme.titulo}', style: TextStyle(fontSize: 18)),
            Text('Gênero: ${filme.genero}'),
            Text('Faixa Etária: ${filme.faixaEtaria}'),
            Text('Duração: ${filme.duracao} min'),
            Text('Ano: ${filme.ano}'),
            SizedBox(height: 10),
            Text('Descrição:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(filme.descricao),
            SizedBox(height: 10),
            RatingBarIndicator(
              rating: filme.pontuacao,
              itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
