import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:registros_carros/modelos_datos/carros_model.dart';

class DBCarros {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), "carros.db"),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE carros (idCarro INTEGER PRIMARY KEY AUTOINCREMENT, apodo TEXT(30))',
      );
    }, version: 1);
  }

  Future<List<Carro>> getCarros() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> carrosMaps = await db.query('carros');

    return List.generate(
      carrosMaps.length,
      (i) => Carro(
        idCarro: carrosMaps[i]['idCarro'],
        apodo: carrosMaps[i]['apodo'],
      ),
    );
  }

  Future<void> insertCarro(Carro carro) async {
    Database db = await _openDB();
    await db.insert(
      'carros',
      carro.toMap(),
    );
  }

  Future<void> deleteCarro(Carro carro) async {
    Database db = await _openDB();
    await db.delete(
      'carros',
      where: 'idCarro = ?',
      whereArgs: [carro.idCarro],
    );
  }

  Future<void> updateCarro(Carro carro) async {
    Database db = await _openDB();
    await db.update(
      'carros',
      carro.toMap(),
      where: 'idCarro = ?',
      whereArgs: [carro.idCarro],
    );
  }
}
