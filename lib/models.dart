class PokemonIndex {
  final int id;
  final String name;
  String get picture =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  PokemonIndex({required this.id, required this.name});

  @override
  String toString() {
    return "PokemonIndex(id: $id, name: $name)";
  }

  factory PokemonIndex.fromJson(int id, Map<String, dynamic> json) {
    return PokemonIndex(id: id, name: json['name']);
  }
}

class Pokemon {
  final int id;
  final String name;
  final String color;
  final List<String> types;

  String get picture =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  Pokemon(
      {required this.id,
      required this.name,
      required this.color,
      required this.types});

  factory Pokemon.fromJson(String color, Map<String, dynamic> json) {
    List<String> types = [];
    json['types'].forEach((type) {
      types.add(type['type']['name']);
    });
    return Pokemon(
        id: json['id'], name: json['name'], color: color, types: types);
  }
}
