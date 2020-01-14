class Establishment {
  double latitude;
  double longitude;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int id;

  Establishment({
    this.latitude,
    this.longitude,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory Establishment.fromJson(Map<String, dynamic> json) =>
      Establishment(
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        name: json["nome"] == null ? null : json["nome"],
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
        "nome": this.name,
        "id": this.id != null ? this.id : 0
      };
}
