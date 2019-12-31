import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:midow/model/estabelecimento.dart';
import 'package:rxdart/rxdart.dart';

class EstabelecimentoBloc extends BlocBase {
  List<Estabelecimento> estabelecimentos = new List();

  // final _increment = new BehaviorSubject<int>();

  // final estabelecimentos = new BehaviorSubject<List<Estabelecimento>>();

  bool loading = false;

  EstabelecimentoBloc() {
    Estabelecimento e1 = Estabelecimento(
        id: 1, nome: 'Teste', latitude: -28.444702, longitude: -52.201980);
    estabelecimentos.add(e1);

    // estabelecimentos.add(_estabelecimentos);
    notifyListeners();
  }

  changeTeste(Estabelecimento e) {
    Estabelecimento e2 = Estabelecimento(
        id: estabelecimentos.length + 1,
        nome: 'Teste',
        latitude: e.latitude,
        longitude: e.longitude);
    estabelecimentos.add(e2);
  }

  @override
  void dispose() {
    super.dispose();
    // estabelecimentos.close();
  }
}
