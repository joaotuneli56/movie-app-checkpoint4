import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/favorites.dart';
import 'package:movie_app/pages/movie_detail/widgets/opinion_modal.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  bool _isFavorite = false;
  bool _isAdding = false;

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    String formattedReleaseDate = movie.releaseDate != null
        ? DateFormat('dd/MM/yyyy').format(movie.releaseDate!)
        : 'Unknown';

    void _showOpinionModal(BuildContext context) {
      showDialog(
        context: context,
        builder: (ctx) => OpinionModal(onSave: (opinion) {
          print(opinion);
        }),
      );
    }

    void _addToFavorites() {
      setState(() {
        _isAdding = true;
      });

      Favorites.addFavorite(movie);

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _isAdding = false;
          _isFavorite = true;
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 5),
                      Text(
                        movie.voteAverage.toString(),
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Overview:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    movie.overview,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text(
                        'Release Date:',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formattedReleaseDate,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Colocar os botões horizontalmente
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Botão "Adicionar Opinião" (Azul)
                      ElevatedButton(
                        onPressed: () => _showOpinionModal(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40), // Botão maior
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.blue, // Cor azul
                        ),
                        child: const Text(
                          'Adicionar Opinião',
                          style: TextStyle(fontSize: 18), // Texto maior
                        ),
                      ),
                      // Botão "Adicionar à Minha Lista" (Verde)
                      ElevatedButton(
                        onPressed: _isAdding ? null : _addToFavorites,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40), // Botão maior
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: _isAdding ? Colors.grey : Colors.green, // Cor verde
                        ),
                        child: _isAdding
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Text('Adicionando...'),
                                ],
                              )
                            : const Text(
                                'Adicionar à Minha Lista',
                                style: TextStyle(fontSize: 18), // Texto maior
                              ),
                      ),
                    ],
                  ),
                  if (_isFavorite) // Exibe mensagem de sucesso
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Filme adicionado à sua lista!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
