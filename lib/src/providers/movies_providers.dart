import 'dart:async';
import 'dart:convert';
import 'package:flutter_movies/src/models/actor_models.dart';
import 'package:flutter_movies/src/models/movie_models.dart';
import 'package:http/http.dart' as http;

class MoviesProviders {
  String _url = 'api.themoviedb.org';
  String _apiKey = '7509510d9977fe4e85ac3f5ab5103fd2';
  String _language = 'en-US';
  int _popularsPage = 0;
  List<Movie> _populars = new List();
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();
  bool _isLoading = false;

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processRequest(url) async {
    final request = await http.get(url);
    final decodeData = json.decode(request.body);
    final movies = new Movies.fromJsonList(decodeData['results']);
    return movies.items;
  }

  Future<List<Movie>> getCinema() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return _processRequest(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_isLoading) return [];
    _isLoading = true;
    _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });
    final resp = await _processRequest(url);
    _populars.addAll(resp);
    popularsSink(_populars);
    _isLoading = false;
    return resp;
  }

  Future<List<Actor>> getCast(String idMovie) async {
    final url = Uri.https(_url, '3/movie/$idMovie/credits', {
      'api_key': _apiKey,
      'language': _language,
    });
    final request = await http.get(url);
    final decodeData = json.decode(request.body);
    final cast = new Cast.fromJsonList(decodeData['cast']);
    return cast.actors;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    return _processRequest(url);
  }
}
