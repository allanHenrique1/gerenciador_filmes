import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class FilmeDatabase {
  static final FilmeDatabase instance = FilmeDatabase._init();

  static Database? _database;

  FilmeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('filmes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, filePath);
      return await openDatabase(path, version: 1, onCreate: _createDB);
    } catch (e) {
      rethrow;
    }
  }

  Future _createDB(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE filmes ( 
          id INTEGER PRIMARY KEY AUTOINCREMENT, 
          urlImagem TEXT NOT NULL,
          titulo TEXT NOT NULL,
          genero TEXT NOT NULL,
          faixaEtaria TEXT NOT NULL,
          duracao INTEGER NOT NULL,
          pontuacao REAL NOT NULL,
          descricao TEXT NOT NULL,
          ano INTEGER NOT NULL
        )
      ''');
    } catch (e) {
      rethrow;
    }
  }

  Future close() async {
    try {
      final db = await instance.database;
      await db.close();
    } catch (e) {
      // Pode ignorar ou logar
    }
  }
}
