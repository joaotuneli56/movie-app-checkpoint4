class Favorites {
  static List<int> favoriteMovieIds = [];

  static void addFavorite(int movieId) {
    if (!favoriteMovieIds.contains(movieId)) {
      favoriteMovieIds.add(movieId);
    }
  }

  static bool isFavorite(int movieId) {
    return favoriteMovieIds.contains(movieId);
  }
}
