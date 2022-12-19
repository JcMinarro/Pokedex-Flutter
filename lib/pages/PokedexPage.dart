import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/repository.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key, required this.title});

  final String title;

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<PokemonIndex>>(
          future: repository.getPokemons(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var pokemons = snapshot.data!;
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1,
                  ),
                  itemCount: pokemons.length,
                  controller: ScrollController(),
                  itemBuilder: (context, index) =>
                      pokemons[index].toWidget(context));
            } else {
              return Center(
                  child: Stack(children: [CircularProgressIndicator()]));
            }
          }),
    );
  }
}

extension PokemonCard on PokemonIndex {
  Widget toWidget(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () => _showPokemon(context),
        child: Center(
          child: Column(children: [
            Text(
              name,
              style: TextStyle(fontSize: 30),
            ),
            Image.network(
              picture,
              height: 100,
            ),
          ]),
        ),
      ),
    );
  }

  _showPokemon(BuildContext context) {
    Navigator.pushNamed(context, "/pokemon", arguments: this);
  }
}
