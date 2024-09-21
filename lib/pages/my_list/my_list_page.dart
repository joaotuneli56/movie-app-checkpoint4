import 'package:flutter/material.dart';
import 'package:movie_app/models/favorites.dart';

class MyListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minha Lista')),
      body: ListView.builder(
        itemCount: Favorites.favoriteMovieIds.length,
        itemBuilder: (context, index) {
          int movieId = Favorites.favoriteMovieIds[index];
          return ListTile(
            title: Text('Filme ID: $movieId'),
          );
        },
      ),
    );
  }
}
