import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final String year;
  final String genre;
  final String poster;

  Movie(this.id, this.title, this.year, this.genre, this.poster);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        year = json["year"],
        genre = json["genre"],
        poster = json["poster"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['year'] = this.year;
    data['genre'] = this.genre;
    data['poster'] = this.poster;
    return data;
  }
}
