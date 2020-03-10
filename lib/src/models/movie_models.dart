class Movies {
  List<Movie> items = new List();

  Movies(this.items);

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((actor) {
      final item = new Movie.fromJsonMap(actor);
      items.add(item);
    });
  }
}

class Movie {
  String uniqueId ;
  double popularity;
  double vote_count;
  bool video;
  String poster_path;
  int id;
  bool adult;
  String backdrop_path;
  String original_language;
  String original_title;
  List<int> genre_ids;
  String title;
  double vote_average;
  String overview;
  String release_date;

  Movie.fromJsonMap(Map<String, dynamic> map)
      : popularity = map["popularity"] / 1,
        vote_count = map["vote_count"] / 1,
        video = map["video"],
        poster_path = map["poster_path"],
        id = map["id"],
        adult = map["adult"],
        backdrop_path = map["backdrop_path"],
        original_language = map["original_language"],
        original_title = map["original_title"],
        genre_ids = List<int>.from(map["genre_ids"]),
        title = map["title"],
        vote_average = map["vote_average"] / 1,
        overview = map["overview"],
        release_date = map["release_date"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = popularity;
    data['vote_count'] = vote_count;
    data['video'] = video;
    data['poster_path'] = poster_path;
    data['id'] = id;
    data['adult'] = adult;
    data['backdrop_path'] = backdrop_path;
    data['original_language'] = original_language;
    data['original_title'] = original_title;
    data['genre_ids'] = genre_ids;
    data['title'] = title;
    data['vote_average'] = vote_average;
    data['overview'] = overview;
    data['release_date'] = release_date;
    return data;
  }

  Movie(
      this.popularity,
      this.vote_count,
      this.video,
      this.poster_path,
      this.id,
      this.adult,
      this.backdrop_path,
      this.original_language,
      this.original_title,
      this.genre_ids,
      this.title,
      this.vote_average,
      this.overview,
      this.release_date);

  getPosterImg() {
    var retorno =
        'https://unamo.com/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png';
    if (poster_path != null) {
      retorno = 'https://image.tmdb.org/t/p/w500/$poster_path';
    }
    return retorno;
  }

  getBackgroundImg() {
    var retorno =
        'https://unamo.com/assets/camaleon_cms/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png';
    if (poster_path != null) {
      retorno = 'https://image.tmdb.org/t/p/w500/$backdrop_path';
    }
    return retorno;
  }
}
