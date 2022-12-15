import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokedex/models.dart';

class Repository {
  Future<List<PokemonIndex>> getPokemons() async {
    List<PokemonIndex> pokemons = [];
    var pokemonResponse = await http
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=150"));
    var asMap = jsonDecode(pokemonResponse.body)['results'].asMap();
    var entries = asMap.entries;
    entries.forEach((entry) =>
        {pokemons.add(PokemonIndex.fromJson(entry.key + 1, entry.value))});
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
