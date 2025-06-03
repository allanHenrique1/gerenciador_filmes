import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../controllers/filme_controller.dart';
import '../models/filme.dart';

class FilmeFormView extends StatefulWidget {
  final Filme? filme;

  const FilmeFormView({super.key, this.filme});

  @override
  // ignore: library_private_types_in_public_api
  _FilmeFormViewState createState() => _FilmeFormViewState();
}

class _FilmeFormViewState extends State<FilmeFormView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _urlImagemController;
  late TextEditingController _tituloController;
  late TextEditingController _generoController;
  String _faixaEtaria = 'Livre';
  late TextEditingController _duracaoController;
  double _pontuacao = 0.0;
  late TextEditingController _descricaoController;
  late TextEditingController _anoController;

  @override
  void initState() {
    super.initState();

    _urlImagemController = TextEditingController(
      text: widget.filme?.urlImagem ?? '',
    );
    _tituloController = TextEditingController(text: widget.filme?.titulo ?? '');
    _generoController = TextEditingController(text: widget.filme?.genero ?? '');
    _faixaEtaria = widget.filme?.faixaEtaria ?? 'Livre';
    _duracaoController = TextEditingController(
      text: widget.filme?.duracao.toString() ?? '',
    );
    _pontuacao = widget.filme?.pontuacao ?? 0.0;
    _descricaoController = TextEditingController(
      text: widget.filme?.descricao ?? '',
    );
    _anoController = TextEditingController(
      text: widget.filme?.ano.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _urlImagemController.dispose();
    _tituloController.dispose();
    _generoController.dispose();
    _duracaoController.dispose();
    _descricaoController.dispose();
    _anoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FilmeController>(context);
    final isEditing = widget.filme != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Filme' : 'Cadastrar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('URL da Imagem', _urlImagemController),
              _buildTextField('Título', _tituloController),
              _buildTextField('Gênero', _generoController),
              _buildDropdownFaixaEtaria(),
              _buildTextField(
                'Duração (min)',
                _duracaoController,
                isNumeric: true,
              ),
              _buildRatingBar(),
              _buildTextField('Descrição', _descricaoController, maxLines: 3),
              _buildTextField('Ano', _anoController, isNumeric: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final filme = Filme(
                      id: widget.filme?.id,
                      urlImagem: _urlImagemController.text,
                      titulo: _tituloController.text,
                      genero: _generoController.text,
                      faixaEtaria: _faixaEtaria,
                      duracao: int.parse(_duracaoController.text),
                      pontuacao: _pontuacao,
                      descricao: _descricaoController.text,
                      ano: int.parse(_anoController.text),
                    );

                    if (isEditing) {
                      controller.updateFilme(filme);
                    } else {
                      controller.addFilme(filme);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(isEditing ? 'Salvar Alterações' : 'Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool isNumeric = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Campo obrigatório';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdownFaixaEtaria() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _faixaEtaria,
        items:
            ['Livre', '10', '12', '14', '16', '18']
                .map(
                  (faixa) => DropdownMenuItem(value: faixa, child: Text(faixa)),
                )
                .toList(),
        onChanged: (value) {
          setState(() {
            _faixaEtaria = value!;
          });
        },
        decoration: InputDecoration(
          labelText: 'Faixa Etária',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildRatingBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Pontuação'),
          RatingBar.builder(
            initialRating: _pontuacao,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              setState(() {
                _pontuacao = rating;
              });
            },
          ),
        ],
      ),
    );
  }
}
