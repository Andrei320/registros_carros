import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

late Database db;

class DBCarro {
  static Future<void> initializeDatabase() async {
    var fabricaBaseDatos = databaseFactoryFfiWeb;
    String rutaBaseDatos =
        '${await fabricaBaseDatos.getDatabasesPath()}/carros.db';

    db = await fabricaBaseDatos.openDatabase(
      rutaBaseDatos,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE carros (idcarro INTEGER PRIMARY KEY AUTOINCREMENT, apodo TEXT(35) NOT NULL, archivado INT default 1);');
        },
      ),
    );
  }

//BD PARA CARROS

  static Future<void> addCarro(String apodo) async {
    await db.rawInsert('INSERT INTO carros (apodo) VALUES (?)', [apodo]);
  }

  static Future<void> deleteCarro(int id) async {
    await db.rawDelete('DELETE FROM carros WHERE idcarro = ?', [id]);
  }

  static Future<void> updateCarro(String apodo) async {
    await db.rawUpdate('UPDATE carro SET apodo = ? WHERE idcarro = ?', [apodo]);
  }

  static Future<List<Map<String, dynamic>>> getCarros() async {
    var resultadoConsulta =
        await db.rawQuery('SELECT * FROM carros ORDER BY archivado DESC;');
    return resultadoConsulta;
  }

//BD PARA MOVIMIENTOS

  static Future<void> insertarMovimiento(
      String nombre, String descripcion, int monto, String fecha) async {
    await db.rawInsert(
        'INSERT INTO MOVIMIENTOS (NOMBRE, DESCRIPCION, MONTO, FECHA) VALUES (?,?,?,?)',
        [nombre, descripcion, monto, fecha]);
  }

  static Future<void> eliminarMovimiento() async {
    await db.rawDelete('DELETE FROM MOVIMIENTOS WHERE ID = ?');
  }

//BD PARA CATEGORIAS
}
