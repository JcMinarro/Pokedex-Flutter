import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/":
              return const PokedexPage(title: "Pokedex");
            case "/pokemon":
              return PokemonPage(
                  pokemonIndex: settings.arguments as PokemonIndex);
          }
          throw UnimplementedError();
        });
      },
    );
  }
}

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
