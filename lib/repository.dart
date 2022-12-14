import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models.dart';

class Repository {
  Future<List<Pokemon>> getPokemons() async {
    List<Pokemon> pokemons = [];
    for (int i = 1; i <= 150; i++) {
      pokemons.add(await getPokemon(i));
    }
    return pokemons;
  }

  Future<Pokemon> getPokemon(id) async {
    var pokemonResponse =
        http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon/$id"));
    // var pokemonSpeciesResponse =
    //     http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon-species/$id"));
    //
    // var color = jsonDecode((await pokemonSpeciesResponse).body)['color'];
    return Pokemon.fromJson("green", jsonDecode((await pokemonResponse).body));
  }
}
