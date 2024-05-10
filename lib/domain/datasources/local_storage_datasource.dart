import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDatasource {
  Future<void> toggleFavourite(Movie movie); //manda la pelicula
  Future<bool> isMovieFavourite(int movieId);
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
