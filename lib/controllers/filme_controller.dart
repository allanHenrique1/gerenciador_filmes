import 'package:flutter/material.dart';
import '../data/dao/filme_dao.dart';
import '../models/filme.dart';

class FilmeController with ChangeNotifier {
  final FilmeDao _dao = FilmeDao();
  List<Filme> filmes = [];

  Future<void> loadFilmes() async {
    filmes = await _dao.getAllFilmes();
    notifyListeners();
  }

  Future<void> addFilme(Filme filme) async {
    await _dao.insertFilme(filme);
    await loadFilmes();
  }

  Future<void> updateFilme(Filme filme) async {
    await _dao.updateFilme(filme);
    await loadFilmes();
  }

  Future<void> deleteFilme(int id) async {
    await _dao.deleteFilme(id);
    await loadFilmes();
  }
}
