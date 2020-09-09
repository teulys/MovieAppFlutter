import 'dart:async';
import 'dart:convert';

import 'package:peliculas/src/model/actores_model.dart';
import 'package:peliculas/src/model/peliculas_model.dart';

import 'package:http/http.dart' as http;

class PeliculaProvider {
  String _apiKey = 'c0130afe5996d8bcba9cd26e22c080e3';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _currentPage = 0;
  bool _cargando = false;

  List<Pelicula> _listPopulares = List();

  final _popularesStreamContoller = new StreamController<List<Pelicula>>();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamContoller.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamContoller.stream;

  Future<List<Pelicula>> _traerRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    // print(decodeData['results']);
    final peliculas = Peliculas.fromJason(decodeData['results']);

    // print(peliculas.items[0].title);

    return peliculas.items;
  }

  void streamDispouse() {
    _popularesStreamContoller?.close();
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return _traerRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    _currentPage++;
    print('Current Page $_currentPage');
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _currentPage.toString(),
    });

    var resp = await _traerRespuesta(url);

    _listPopulares.addAll(resp);
    popularesSink(_listPopulares);

    _cargando = false;
    return resp;
  }

  Future<Actores> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key': _apiKey,
      'language': _language,
    });

    var resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    return Actores.fromJson(decodeData);
  }

  Future<List<Pelicula>> findPeliculas(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    return _traerRespuesta(url);
  }
}
