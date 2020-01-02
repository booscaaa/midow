import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:midow/api/estabelecimento.dart';
import 'package:midow/model/estabelecimento.dart';
import 'package:rxdart/rxdart.dart';

class EstabelecimentoBloc extends BlocBase {
  List<Estabelecimento> _estabelecimentos = new List();
  EstabelecimentoAPI api = new EstabelecimentoAPI();

 final estabelecimentos = new BehaviorSubject<List<Estabelecimento>>(); //the BehaviorSubject gets the last value

  bool loading = false;
  bool isClose = false;

  _changeLoading(bool isLoading) {
    this.loading = isLoading;

    if (!isLoading) {
      this.isClose = true;
    }
    notifyListeners();
  }

  index() async {
    List<Estabelecimento> est = await api.index();
    this._estabelecimentos = est;
     estabelecimentos.sink.add(_estabelecimentos);
    // notifyListeners();
  }

  store(Estabelecimento e) async {
    _changeLoading(true);

    Estabelecimento estabelecimento = await api.store(e);
    _estabelecimentos.add(estabelecimento);

    estabelecimentos.sink.add(_estabelecimentos);

    _changeLoading(false);
  }

  @override
  void dispose() {
    estabelecimentos.close();
    super.dispose();
  }
}
