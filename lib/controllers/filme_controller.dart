import 'package:flutter/material.dart';
import '../data/dao/filme_dao.dart';
import '../models/filme.dart';

class FilmeController with ChangeNotifier {
  final FilmeDao _dao = FilmeDao();
  List<Filme> filmes = [];

  Future<void> loadFilmes() async {
    try {
      filmes = await _dao.getAllFilmes();
      notifyListeners();
    } catch (e) {
      // Log de erro opcional
    }
  }

  Future<void> addFilme(Filme filme) async {
    try {
      final id = await _dao.insertFilme(filme);
      if (id != -1) {
        await loadFilmes();
      }
    } catch (e) {
      // Log de erro opcional
    }
  }

  Future<void> updateFilme(Filme filme) async {
    try {
      final count = await _dao.updateFilme(filme);
      if (count > 0) {
        await loadFilmes();
      }
    } catch (e) {
      // Log de erro opcional
    }
  }

  Future<void> deleteFilme(int id) async {
    try {
      final count = await _dao.deleteFilme(id);
      if (count > 0) {
        await loadFilmes();
      }
    } catch (e) {
      // Log de erro opcional
    }
  }
}
