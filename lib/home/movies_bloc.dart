import 'package:movie_app/home/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'movies_repository.dart';

class MoviesBloc {
  final MoviesRepository _repository = MoviesRepository();
  final BehaviorSubject<List<Movie>> _subject = BehaviorSubject<List<Movie>>();

  getMovies() async {
    List<Movie> response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<List<Movie>> get subject => _subject;
}

final bloc = MoviesBloc();
