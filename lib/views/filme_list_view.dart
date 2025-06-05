import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../controllers/filme_controller.dart';
import '../models/filme.dart';
import 'filme_detail_view.dart';
import 'filme_form_view.dart';

enum OpcaoFilme { exibir, alterar }

class FilmeListView extends StatefulWidget {
  const FilmeListView({super.key});

  @override
  State<FilmeListView> createState() => _FilmeListViewState();
}

class _FilmeListViewState extends State<FilmeListView> {
  late FilmeController controller;

  @override
  void initState() {
    super.initState();
    controller = Provider.of<FilmeController>(context, listen: false);
    controller.loadFilmes();
  }

  @override
  Widget build(BuildContext context) {
    final rootContext = context; 
    controller = Provider.of<FilmeController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              showDialog(
                context: rootContext,
                builder:
                    (_) => AlertDialog(
                      title: const Text('Grupo'),
                      content: const Text('Allan Henrique Rodrigues de Meireles'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(rootContext),
                          child: const Text('Fechar'),
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
              ? const Center(child: Text('Nenhum filme cadastrado.'))
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
                          onPressed: (_) => _handleOpcoes(rootContext, filme),
                          backgroundColor: Colors.grey[700]!,
                          foregroundColor: Colors.white,
                          icon: Icons.more_horiz,
                          label: 'Opções',
                        ),
                        SlidableAction(
                          onPressed: (_) async {
                            await controller.deleteFilme(filme.id!);
                            ScaffoldMessenger.of(rootContext).showSnackBar(
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
                        leading:
                            filme.urlImagem.isNotEmpty
                                ? Image.network(
                                  filme.urlImagem,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          const Icon(Icons.broken_image),
                                )
                                : const Icon(Icons.image_not_supported),
                        title: Text(filme.titulo),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gênero: ${filme.genero}'),
                            Text('Ano: ${filme.ano}'),
                            RatingBarIndicator(
                              rating: filme.pontuacao,
                              itemBuilder:
                                  (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
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
            rootContext,
            MaterialPageRoute(builder: (context) => const FilmeFormView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<OpcaoFilme?> _showOpcoes(BuildContext context) {
    return showModalBottomSheet<OpcaoFilme>(
      context: context,
      builder:
          (context) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.visibility),
                  title: const Text('Exibir Dados'),
                  onTap: () {
                    Navigator.pop(context, OpcaoFilme.exibir);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Alterar'),
                  onTap: () {
                    Navigator.pop(context, OpcaoFilme.alterar);
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _handleOpcoes(BuildContext context, Filme filme) async {
    final opcao = await _showOpcoes(context);

    if (opcao == OpcaoFilme.exibir) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FilmeDetailView(filme: filme)),
      );
    } else if (opcao == OpcaoFilme.alterar) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FilmeFormView(filme: filme)),
      );
    }
  }
}
