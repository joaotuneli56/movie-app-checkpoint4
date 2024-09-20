import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieSearchItem extends StatelessWidget {
  final Movie movie;

  MovieSearchItem({required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
        fit: BoxFit.cover,
      ),
      title: Text(movie.title),
      subtitle: Text('Rating: ${movie.voteAverage.toString()}'),
      onTap: () {
        Navigator.pushNamed(context, '/movieDetail', arguments: movie);
      },
    );
  }
}
