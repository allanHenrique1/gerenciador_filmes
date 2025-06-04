import '../../models/filme.dart';
import '../filme_database.dart';

class FilmeDao {
  final dbProvider = FilmeDatabase.instance;

  Future<int> insertFilme(Filme filme) async {
    try {
      final db = await dbProvider.database;
      return await db.insert('filmes', filme.toMap());
    } catch (e) {
      // Log de erro opcional
      return -1;
    }
  }

  Future<List<Filme>> getAllFilmes() async {
    try {
      final db = await dbProvider.database;
      final result = await db.query('filmes');
      return result.map((map) => Filme.fromMap(map)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<int> updateFilme(Filme filme) async {
    try {
      final db = await dbProvider.database;
      return await db.update(
        'filmes',
        filme.toMap(),
        where: 'id = ?',
        whereArgs: [filme.id],
      );
    } catch (e) {
      return -1;
    }
  }

  Future<int> deleteFilme(int id) async {
    try {
      final db = await dbProvider.database;
      return await db.delete('filmes', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      return -1;
    }
  }
}
