import 'package:flutter/material.dart';
import 'package:movie_app/models/favorites.dart';
import 'package:movie_app/models/movie_model.dart';

class WatchlistPage extends StatefulWidget {
  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: ListView.builder(
        itemCount: Favorites.favoriteMovies.length,
        itemBuilder: (context, index) {
          Movie movie = Favorites.favoriteMovies[index];
          return ListTile(
            title: Text(movie.title),
            leading: Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              width: 50,
              fit: BoxFit.cover,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Excluir o filme da watchlist
                setState(() {
                  Favorites.removeFavorite(movie.id);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${movie.title} removido da Watchlist!')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
