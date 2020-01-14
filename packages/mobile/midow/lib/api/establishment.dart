import 'package:midow/model/establishment.dart';
import 'package:dio/dio.dart';

class EstablishmentAPI {
  Future<Establishment> store(Establishment e) async {
    Dio dio = new Dio();
    print(e.toJson());
    Response response = await dio.post(
        "http://192.168.200.65:3333/estabelecimento",
        data: e.toJson(),
        options:
            Options(headers: {Headers.contentTypeHeader: "application/json"}));

    print(response.data);

    return Establishment.fromJson(response.data);
  }

  Future<List<Establishment>> index() async {
    Dio dio = new Dio();
    Response response = await dio.get(
        "http://192.168.200.65:3333/estabelecimento",
        options:
            Options(headers: {Headers.contentTypeHeader: "application/json"}));

    print(response.data);

    return response.data.map<Establishment>((est) {
      print(est);
      return Establishment.fromJson(est);
    }).toList();
  }
}
