import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

//Codigo reutilizable, Lee las peliculas fav provenientes del proveedor,
//notifica y carga la siguiente lista de peliculas
class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    ref.read(favoriteMoviesProvider.notifier).loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading == true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

//Codigo reutilizable, Mira las peliculas favoritas notificadas anteriormente,
//verifica el valor de la pelicula y incrementa automaticamente la lista de pelicuals
  @override
  Widget build(BuildContext context) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();
    if (favoriteMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border_sharp,
              size: 60,
              color: colors.primary,
            ),
            Text(
              "Upsi!!!!",
              style: TextStyle(fontSize: 40, color: colors.primary),
            ),
            const Text(
              "Elige una peli y vuelve aqui :)",
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      body: MovieMasonry(
        movies: favoriteMovies,
        loadnextPage: loadNextPage,
      ),
    );
  }
}
