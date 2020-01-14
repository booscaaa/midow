import 'package:midow/model/establishment.dart';
import './database-helper.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class FavoritoProvider {
  Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    db = await openDatabase(databasesPath + 'midow.db', version: VERSION,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table favoritos ( 
          id integer primary key autoincrement, 
          nome text not null,
          latitude number not null,
          longitude number not null)
        ''');
    }, onUpgrade: (Database db, int version, int other) async {
      //TODO
    });
  }

  Future<Establishment> insert(Establishment estabelecimento) async {
    await db.insert('favoritos', estabelecimento.toJson());
    return estabelecimento;
  }

  Future<Establishment> getEstabelecimento(int id) async {
    List<Map> maps = await db.query('favoritos',
        columns: ['*'], where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Establishment.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Establishment>> getEstabelecimentos() async {
    List<Map> maps = await db.query('favoritos', columns: ['*']);

    List<Establishment> estabelecimentos = maps.map<Establishment>((est) {
      return Establishment.fromJson(est);
    }).toList();

    return estabelecimentos;
  }

  Future<int> delete(int id) async {
    return await db.delete('favoritos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Establishment estabelecimento) async {
    return await db.update('favoritos', estabelecimento.toJson(),
        where: 'id = ?', whereArgs: [estabelecimento.id]);
  }

  Future close() async => db.close();
}
