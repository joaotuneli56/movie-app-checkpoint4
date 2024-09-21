import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class MoviesHorizontalList extends StatelessWidget {
  final List<Movie> movies;
  final Function(Movie) onTap; // Adicione isso

  const MoviesHorizontalList({super.key, required this.movies, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () => onTap(movie), // Chame onTap ao tocar no filme
            child: Container(
              width: 130,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
