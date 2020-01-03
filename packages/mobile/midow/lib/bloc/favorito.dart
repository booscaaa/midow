import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:midow/api/estabelecimento.dart';
import 'package:midow/model/estabelecimento.dart';
import 'package:midow/provider/favorito.dart';
import 'package:rxdart/rxdart.dart';

class FavoritoBloc extends BlocBase {
  List<Estabelecimento> _estabelecimentos = new List();
  EstabelecimentoAPI api = new EstabelecimentoAPI();

  final estabelecimentos = new BehaviorSubject<
      List<Estabelecimento>>(); //the BehaviorSubject gets the last value

  bool loading = false;
  bool isClose = false;

  FavoritoBloc() {
    _getFavoritos();
  }

  _getFavoritos() async {
    FavoritoProvider fp = new FavoritoProvider();
    await fp.open();
    _estabelecimentos = await fp.getEstabelecimentos();
    estabelecimentos.sink.add(_estabelecimentos);
    fp.close();
  }

  add(Estabelecimento e) async {
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
