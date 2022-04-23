import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'movie.dart';
import 'movies_exception.dart';

// final movieServiceProvider = Provider<MovieService>((ref) {
//   return MovieService(Dio());
// });

class MovieService {
  //MovieService(this._dio);

  final Dio _dio = Dio();

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio.get(
        "http://movies-sample.herokuapp.com/api/movies",
      );

      final results = List<Map<String, dynamic>>.from(response.data['data']);

      List<Movie> movies = results
          .map((movieData) => Movie.fromJson(movieData))
          .toList(growable: false);
      print(movies);
      return movies;
    } on DioError catch (dioError) {
      throw MoviesException.fromDioError(dioError);
    }
  }
}
