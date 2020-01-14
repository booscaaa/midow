import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:midow/model/establishment.dart';
import 'package:midow/api/establishment.dart';
import 'package:rxdart/rxdart.dart';

class EstablishmentBloc extends BlocBase {
  List<Establishment> _estabelecimentos = new List();
  EstablishmentAPI api = new EstablishmentAPI();

  final estabelecimentos = new BehaviorSubject<
      List<Establishment>>(); //the BehaviorSubject gets the last value

  bool loading = false;
  bool isClose = false;

  changeLoading(bool isLoading) {
    this.loading = isLoading;

    if (!isLoading) {
      this.isClose = true;
    }
    notifyListeners();
  }

  index() async {
    List<Establishment> est = await api.index();
    this._estabelecimentos = est;
    estabelecimentos.sink.add(_estabelecimentos);
    // notifyListeners();
  }

  store(Establishment e) async {
    changeLoading(true);

    try {
      Establishment estabelecimento = await api.store(e);
      _estabelecimentos.add(estabelecimento);

      estabelecimentos.sink.add(_estabelecimentos);
    } catch (e) {}

    changeLoading(false);
  }

  @override
  void dispose() {
    estabelecimentos.close();
    super.dispose();
  }
}
