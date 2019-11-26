import 'package:sicobfilmes/model/generos.dart';

class Filmes {
  final double popularity;
  final int id;
  final bool video;
  final int voteCount;
  final double voteAverage;
  final String title;
  final String releaseDate;
  final String originalLanguage;
  final String originalTitle;
  final String backdropPath;
  final bool adult;
  final String overview;
  final String posterPath;
  final int runtime;
  final List<Generos> generos;
  bool favorito;

  Filmes(
      {this.popularity,
      this.id,
      this.video,
      this.voteCount,
      this.voteAverage,
      this.title,
      this.releaseDate,
      this.originalLanguage,
      this.originalTitle,
      this.backdropPath,
      this.adult,
      this.overview,
      this.posterPath,
      this.runtime,
      this.generos,
      this.favorito});

  factory Filmes.fromJson(Map<String, dynamic> json, bool favorito) {
    List<Generos> jsonGenres = [];
    var tempo = 0;

    if (json['genres'] != null) {
      var total = json['genres'].length;

      for (var i = 0; i <= total - 1; i++) {
        jsonGenres.add(Generos.fromJson(json['genres'][i]));
      }
    } else {
      jsonGenres = [];
    }

    if (json['runtime'] != null) {
      tempo = json['runtime'];
    }

    return Filmes(
        popularity: json['popularity'].toDouble(),
        id: json['id'],
        video: json['video'],
        voteCount: json['vote_count'],
        voteAverage: json['vote_average'].toDouble(),
        title: json['title'],
        releaseDate: json['release_date'],
        originalLanguage: json['original_language'],
        backdropPath: json['backdrop_path'],
        adult: json['adult'],
        overview: json['overview'],
        posterPath: json['poster_path'],
        originalTitle: json['original_title'],
        runtime: tempo,
        generos: jsonGenres,
        favorito: favorito);
  }
}
