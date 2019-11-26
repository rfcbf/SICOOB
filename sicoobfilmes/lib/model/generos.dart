class Generos {
  final int id;
  final String name;

  Generos({this.id, this.name});

  factory Generos.fromJson(Map<String, dynamic> json) {
    return Generos(
      id: json['id'],
      name: json['name'],
    );
  }
}
