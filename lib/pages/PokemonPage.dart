import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/repository.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key, required this.pokemonIndex});

  final PokemonIndex pokemonIndex;

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  Repository repository = Repository();
  Pokemon? pokemon;

  @override
  void initState() {
    super.initState();
    _fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(widget.pokemonIndex.name),
                expandedHeight: 320,
                backgroundColor: pokemon?.color.toColor() ?? Colors.white,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(widget.pokemonIndex.picture))),
                  child: Container(
                    color: Colors.black.withOpacity(.2),
                  ),
                ),
                pinned: true,
                bottom: const TabBar(
                  labelStyle: TextStyle(fontSize: 25),
                  labelColor: Colors.white,
                  tabs: [Tab(text: "About"), Tab(text: "Base Stats")],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [Text("About"), Text("Base Stats")],
          ),
        ),
      ),
    );
  }

  void _fetchPokemon() async {
    var newPokemon = await repository.getPokemon(widget.pokemonIndex.id);
    setState(() {
      pokemon = newPokemon;
    });
  }
}

extension BackgroundColor on String {
  Color toColor() {
    switch (this) {
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "red":
        return Colors.red;
      case "white":
        return Colors.white;
      case "brown":
        return Colors.brown;
      case "yellow":
        return Colors.yellow;
      case "purple":
        return Colors.purple;
      case "pink":
        return Colors.pink;
      case "gray":
        return Colors.grey;
    }
    return Colors.white;
  }
}
