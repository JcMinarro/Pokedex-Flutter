import 'package:flutter/material.dart';
import 'package:pokedex/models.dart';
import 'package:pokedex/pages/PokedexPage.dart';
import 'package:pokedex/pages/PokemonPage.dart';

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
