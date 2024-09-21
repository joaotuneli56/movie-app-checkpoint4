import 'package:movie_app/models/movie_model.dart';

class Favorites {
  static List<Movie> favoriteMovies = [];

  static void addFavorite(Movie movie) {
    if (!favoriteMovies.any((m) => m.id == movie.id)) {
      favoriteMovies.add(movie);
    }
  }
  
  static void removeFavorite(int movieId) {
    favoriteMovies.removeWhere((movie) => movie.id == movieId);
  }
}
 
