import 'package:flutter/material.dart';

class PokemonIndex {
  final int id;
  final String name;
  String get picture =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
  PokemonIndex({required this.id, required this.name});

  factory PokemonIndex.fromJson(int id, Map<String, dynamic> json) {
    return PokemonIndex(id: id, name: json['name']);
  }
}

class Pokemon extends PokemonIndex {
  final String color;
  final List<String> types;
  final Color staticColor = Colors.green;

  Pokemon(
      {required id, required name, required this.color, required this.types})
      : super(id: id, name: name);

  factory Pokemon.fromJson(String color, Map<String, dynamic> json) {
    List<String> types = [];
    json['types'].forEach((type) {
      types.add(type['type']['name']);
    });
    return Pokemon(
        id: json['id'], name: json['name'], color: color, types: types);
  }
}
