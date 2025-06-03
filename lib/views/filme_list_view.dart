import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../controllers/filme_controller.dart';
import '../models/filme.dart';
import 'filme_detail_view.dart';
import 'filme_form_view.dart';

class FilmeListView extends StatelessWidget {
  const FilmeListView({super.key});

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
                      content: Text('Nome do grupo: [Seu Nome ou Grupo]'),
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

                  return Slidable(
                    key: ValueKey(filme.id),
                    endActionPane: ActionPane(
                      motion: const DrawerMotion(),
                      extentRatio: 0.5,
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            _showOpcoes(context, filme);
                          },
                          backgroundColor: Colors.grey[700]!,
                          foregroundColor: Colors.white,
                          icon: Icons.more_horiz,
                          label: 'Opções',
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            controller.deleteFilme(filme.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${filme.titulo} deletado'),
                              ),
                            );
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Excluir',
                        ),
                      ],
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
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FilmeFormView()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showOpcoes(BuildContext context, Filme filme) {
    showModalBottomSheet(
      context: context,
      builder:
          (_) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.visibility),
                  title: Text('Exibir Dados'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilmeDetailView(filme: filme),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Alterar'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilmeFormView(filme: filme),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }
}
