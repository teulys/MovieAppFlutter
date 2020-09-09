class Peliculas {
  List<Pelicula> items = new List<Pelicula>();

  Peliculas();

  Peliculas.fromJason(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = new Pelicula.fromJason(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  String uniqueId = '';
  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJason(Map<String, dynamic> json) {
    voteCount = json['vote_count'];
    id = json['id'];
    video = json['video'];
    voteAverage = json['vote_average'] / 1;
    title = json['title'];
    popularity = json['popularity'] / 1;
    posterPath = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    backdropPath = json['backdrop_path'];
    adult = json['adult'];
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  String getPosterImg() {
    if (posterPath == null)
      return 'https://www.myswitzerland.com/-/media/unic/project/common/image-not-found.png';

    return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  String getBackgroundImg() {
    if (posterPath == null)
      return 'https://www.myswitzerland.com/-/media/unic/project/common/image-not-found.png';

    return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
