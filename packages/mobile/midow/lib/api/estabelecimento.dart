import 'package:dio/dio.dart';
import 'package:midow/model/estabelecimento.dart';

class EstabelecimentoAPI {
  Future<Estabelecimento> store(Estabelecimento e) async {
    Dio dio = new Dio();
    Response response = await dio.post(
        "http://192.168.200.65:3333/estabelecimento",
        data: e.toJson(),
        options:
            Options(headers: {Headers.contentTypeHeader: "application/json"}));

    return Estabelecimento.fromJson(response.data);
  }

  Future<List<Estabelecimento>> index() async {
    Dio dio = new Dio();
    Response response = await dio.get(
        "http://192.168.200.65:3333/estabelecimento",
        options:
            Options(headers: {Headers.contentTypeHeader: "application/json"}));

    print(response.data);

    return response.data.map<Estabelecimento>((est) {
      print(est);
      return Estabelecimento.fromJson(est);
    }).toList();
  }
}
