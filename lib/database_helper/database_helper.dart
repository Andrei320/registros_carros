import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  final String registrosTable = 'registros';
  final String carrosTable = 'carros';
  final String tipoRegistrosTable = 'tipo_registros';

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'carros.db');
    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    // Crea la tabla de registros
    await db.execute('''
      CREATE TABLE $registrosTable(
        idregistro INTEGER PRIMARY KEY AUTOINCREMENT,
        idcarro INTEGER,
        id_tiporegistro INTEGER,
        cantidad_gastada INTEGER,
        fecha_registro TEXT
      )
    ''');

    // Crea la tabla de carros
    await db.execute('''
      CREATE TABLE $carrosTable(
        idcarro INTEGER PRIMARY KEY AUTOINCREMENT,
        numero_placa TEXT,
        apodo TEXT
      )
    ''');

    // Crea la tabla de tipo_registros
    await db.execute('''
      CREATE TABLE $tipoRegistrosTable(
        idtipo_registro INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT
      )
    ''');
  }
}
