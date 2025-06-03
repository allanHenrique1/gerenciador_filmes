import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../controllers/filme_controller.dart';
import '../models/filme.dart';

class FilmeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FilmeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Filmes'),
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (_) => AlertDialog(
                      title: Text('Grupo'),
                      content: Text(
                        'Grupo : Allan Henrique Rodrigues de Meireles',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Fechar'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body:
          controller.filmes.isEmpty
              ? Center(child: Text('Nenhum filme cadastrado.'))
              : ListView.builder(
                itemCount: controller.filmes.length,
                itemBuilder: (context, index) {
                  final filme = controller.filmes[index];

                  return Dismissible(
                    key: Key(filme.id.toString()),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (_) {
                      controller.deleteFilme(filme.id!);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${filme.titulo} deletado')),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 16),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    child: Card(
                      child: ListTile(
                        leading: Image.network(
                          filme.urlImagem,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(filme.titulo),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gênero: ${filme.genero}'),
                            Text('Ano: ${filme.ano}'),
                            RatingBarIndicator(
                              rating: filme.pontuacao,
                              itemBuilder:
                                  (context, _) =>
                                      Icon(Icons.star, color: Colors.amber),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                        onTap: () {
                          // Aqui você vai colocar: Exibir detalhes ou Editar
                        },
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aqui você vai navegar para a tela de cadastro
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
