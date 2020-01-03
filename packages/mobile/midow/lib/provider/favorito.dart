import 'package:midow/model/estabelecimento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class FavoritoProvider {
  Database db;

  Future open() async {
    var databasesPath = await getDatabasesPath();
    db = await openDatabase(databasesPath + 'midow.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        create table favoritos ( 
          id integer primary key autoincrement, 
          nome text not null,
          latitude number not null,
          longitude number not null)
        ''');
    });
  }

  Future<Estabelecimento> insert(Estabelecimento estabelecimento) async {
    await db.insert('favoritos', estabelecimento.toJson());
    return estabelecimento;
  }

  Future<Estabelecimento> getEstabelecimento(int id) async {
    List<Map> maps = await db.query('favoritos',
        columns: ['*'], where: 'id = ?', whereArgs: [id]);
    if (maps.length > 0) {
      return Estabelecimento.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Estabelecimento>> getEstabelecimentos() async {
    List<Map> maps = await db.query('favoritos', columns: ['*']);

    List<Estabelecimento> estabelecimentos = maps.map<Estabelecimento>((est) {
      return Estabelecimento.fromJson(est);
    }).toList();

    return estabelecimentos;
  }

  Future<int> delete(int id) async {
    return await db.delete('favoritos', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(Estabelecimento estabelecimento) async {
    return await db.update('favoritos', estabelecimento.toJson(),
        where: 'id = ?', whereArgs: [estabelecimento.id]);
  }

  Future close() async => db.close();
}
