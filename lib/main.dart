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
          }
          throw UnimplementedError();
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
                  itemBuilder: (context, index) => pokemons[index].toWidget());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}

extension PokemonCard on PokemonIndex {
  Widget toWidget() {
    return Card(
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
    );
  }
}
