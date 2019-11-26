import 'package:sicobfilmes/model/favoritos.dart';
import 'package:sicobfilmes/model/filmes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const apiKey = 'b9d6d05e8a5eccb91e5fb5f2eb8c87a8';
const request = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR';
const requestMovie = "https://api.themoviedb.org/3/movie/";

class FilmesService {
  List<Filmes> _filmes = [];
  static final favoritosDB = Favoritos.instance;

  Future<List<Filmes>> getFilmes() async {
    _filmes = [];
    var url = request;
    final response = await http.get(url);
    bool favoritoResp = false;

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      for (var i = 0; i <= 19; i++) {
        var quant = await favoritosDB.getMovie(jsonResponse['results'][i]['id'].toString());
        if (quant > 0) {
          favoritoResp = true;
        } else {
          favoritoResp = false;
        }

        _filmes.add(Filmes.fromJson(jsonResponse['results'][i], favoritoResp));
      }

      return _filmes;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<List<Filmes>> getProximaFilmes(String pag) async {
    var url = 'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey&language=pt-BR&page=$pag';
    bool favoritoResp = false;

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      for (var i = 0; i <= 19; i++) {
        var quant = await favoritosDB.getMovie(jsonResponse['results'][i]['id'].toString());
        if (quant > 0) {
          favoritoResp = true;
        } else {
          favoritoResp = false;
        }

        _filmes.add(Filmes.fromJson(jsonResponse['results'][i], favoritoResp));
      }

      return _filmes;
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Filmes> getUnicoFilmes(String idMovie) async {
    var url = requestMovie + "$idMovie?api_key=$apiKey&language=pt-BR";
    bool favoritoResp = false;

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      var quant = await favoritosDB.getMovie(jsonResponse['id'].toString());
      if (quant > 0) {
        favoritoResp = true;
      } else {
        favoritoResp = false;
      }

      return Filmes.fromJson(jsonResponse, favoritoResp);
    } else {
      throw Exception('Failed to load post');
    }
  }
}
