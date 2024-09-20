import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/models/movie_model.dart';
import 'widgets/movie_search_item.dart'; // Import do widget que vai exibir os resultados

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  ApiServices _apiServices = ApiServices();
  List<Movie> _movies = [];
  bool _isLoading = false;
  String _errorMessage = '';

  void _searchMovies(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    try {
      Result result = await _apiServices.searchMovies(query);
      setState(() {
        _movies = result.movies;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to load movies';
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _movies = []; // Limpa a lista ao cancelar a busca
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Movies"),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: _clearSearch,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: CupertinoSearchTextField(
                  padding: const EdgeInsets.all(10.0),
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.grey,
                  ),
                  style: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey.withOpacity(0.3),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _searchMovies(value);
                    } else {
                      setState(() {
                        _movies = []; // Limpa a lista se a busca estiver vazia
                      });
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              if (_isLoading) CircularProgressIndicator(),
              if (_errorMessage.isNotEmpty) Text(_errorMessage),
              if (!_isLoading && _movies.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    final movie = _movies[index];
                    return MovieSearchItem(movie: movie);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
