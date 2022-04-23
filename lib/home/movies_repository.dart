import 'movie.dart';
import 'movie_service.dart';

class MoviesRepository {
  MovieService _apiProvider = MovieService();

  Future<List<Movie>> getMovies() {
    return _apiProvider.getMovies();
  }
}
