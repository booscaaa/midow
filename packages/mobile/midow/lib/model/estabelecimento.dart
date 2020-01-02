class Estabelecimento {
  double latitude;
  double longitude;
  String nome;
  DateTime createdAt;
  DateTime updatedAt;
  int id;

  Estabelecimento({
    this.latitude,
    this.longitude,
    this.nome,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Estabelecimento.fromJson(Map<String, dynamic> json) =>
      Estabelecimento(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        nome: json["nome"] == null ? null : json["nome"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": this.latitude,
        "longitude": this.longitude,
        "nome": this.nome,
      };
}
