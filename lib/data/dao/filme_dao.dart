import 'package:sqflite/sqflite.dart';
import '../../models/filme.dart';
import '../filme_database.dart';

class FilmeDao {
  final dbProvider = FilmeDatabase.instance;

  Future<int> insertFilme(Filme filme) async {
    final db = await dbProvider.database;
    return await db.insert('filmes', filme.toMap());
  }

  Future<List<Filme>> getAllFilmes() async {
    final db = await dbProvider.database;
    final result = await db.query('filmes');

    return result.map((map) => Filme.fromMap(map)).toList();
  }

  Future<int> updateFilme(Filme filme) async {
    final db = await dbProvider.database;
    return await db.update(
      'filmes',
      filme.toMap(),
      where: 'id = ?',
      whereArgs: [filme.id],
    );
  }

  Future<int> deleteFilme(int id) async {
    final db = await dbProvider.database;
    return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
  }
}
