import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:midow/model/establishment.dart';
import 'package:midow/provider/favorite.dart';
import 'package:midow/api/establishment.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc extends BlocBase {
  List<Establishment> _estabelecimentos = new List();
  EstablishmentAPI api = new EstablishmentAPI();

  final estabelecimentos = new BehaviorSubject<
      List<Establishment>>(); //the BehaviorSubject gets the last value

  bool loading = false;
  bool isClose = false;

  FavoritesBloc() {
    _getFavoritos();
  }

  _getFavoritos() async {
    FavoritoProvider fp = new FavoritoProvider();
    await fp.open();
    _estabelecimentos = await fp.getEstabelecimentos();
    estabelecimentos.sink.add(_estabelecimentos);
    fp.close();
  }

  add(Establishment e) async {
    FavoritoProvider fp = new FavoritoProvider();
    await fp.open();
    await fp.insert(e);
    _estabelecimentos.add(e);
    estabelecimentos.sink.add(_estabelecimentos);
    fp.close();
  }

  @override
  void dispose() {
    estabelecimentos.close();
    super.dispose();
  }
}
