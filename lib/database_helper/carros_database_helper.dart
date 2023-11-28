import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

late Database db;

class DBCarro {
  Future<void> initializeDatabase() async {
    print('Inciando la base de datos');
    var fabricaBaseDatos = databaseFactoryFfiWeb;
    String rutaBaseDatos =
        '${await fabricaBaseDatos.getDatabasesPath()}/carros_registros.db';

    db = await fabricaBaseDatos.openDatabase(
      rutaBaseDatos,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE IF NOT EXISTS carros (idcarro INTEGER PRIMARY KEY AUTOINCREMENT, apodo TEXT(35) NOT NULL, archivado INT default 1)');
          print('Creada la tabla carros');

          await db.execute(
              'CREATE TABLE IF NOT EXISTS categorias (idcategoria INTEGER PRIMARY KEY AUTOINCREMENT, nombrecategoria TEXT(35) NOT NULL, archivado INT default 1)');
          print('Creada la tabla categorias');
        },
      ),
    );
  }

//BD PARA CARROS

  Future<List<Map<String, dynamic>>> getCarros() async {
    var resultadoConsulta =
        await db.rawQuery('SELECT * FROM carros ORDER BY archivado DESC;');
    return resultadoConsulta;
  }

  Future<void> addCarro(String apodo) async {
    await db.rawInsert('INSERT INTO carros (apodo) VALUES (?)', [apodo]);
  }

  Future<void> deleteCarro(int id) async {
    await db.rawDelete('DELETE FROM carros WHERE idcarro = ?', [id]);
  }

  Future<void> updateCarro(String apodo, int id) async {
    await db.rawUpdate(
        'UPDATE carros SET apodo = ? WHERE idcarro = ?', [apodo, id]);
  }

  Future<void> archivarCarro(int id) async {
    await db.rawUpdate(
        'UPDATE carros SET archivado = CASE WHEN archivado = 1 THEN 0 WHEN archivado = 0 THEN 1 ELSE archivado END WHERE idcarro = ?',
        [id]);
  }

//DB PARA CATEGORIAS
  Future<List<Map<String, dynamic>>> getCategorias() async {
    var resultadoConsulta =
        await db.rawQuery('SELECT * FROM categorias ORDER BY archivado DESC;');
    return resultadoConsulta;
  }

  Future<void> addCategoria(String nombrecategoria) async {
    await db.rawInsert('INSERT INTO categorias (nombrecategoria) VALUES (?)',
        [nombrecategoria]);
  }

  Future<void> deleteCategoria(int id) async {
    await db.rawDelete('DELETE FROM categorias WHERE idcategoria = ?', [id]);
  }

  Future<void> updateCategoria(String nombrecategoria, int id) async {
    await db.rawUpdate(
        'UPDATE categorias SET nombrecategoria = ? WHERE idcategoria = ?',
        [nombrecategoria, id]);
  }

  Future<void> archivarCategoria(int id) async {
    await db.rawUpdate(
        'UPDATE categorias SET archivado = CASE WHEN archivado = 1 THEN 0 WHEN archivado = 0 THEN 1 ELSE archivado END WHERE idcategoria = ?',
        [id]);
  }

//DB PARA GASTOS
}
