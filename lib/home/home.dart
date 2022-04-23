import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'movies_bloc.dart';
import 'movie.dart';
import 'movie_service.dart';
import 'movies_exception.dart';

final moviesFutureProvider =
    FutureProvider.autoDispose<List<Movie>>((ref) async {
  ref.maintainState = true;

  //final movieService = ref.watch(movieServiceProvider);
  final movies = await bloc.getMovies();
  print(movies);
  return movies;
});

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    bloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        elevation: 0,
        title: const Text('Movies Sample App'),
      ),
      body: StreamBuilder<List<Movie>>(
        stream: bloc.subject.stream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Movie>? movies = snapshot.data;
            return GridView.extent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
              children:
                  movies!.map((movie) => _MovieBox(movie: movie)).toList(),
            );
          } else if (snapshot.hasError) {
            return _ErrorBody(message: "Oops, something unexpected happened");
          } else {
            return _buildLoadingWidget();
          }
        },
      ),
      // body: ref.watch(moviesFutureProvider).when(
      //       error: (e, s) {
      //         if (e is MoviesException) {
      //           return _ErrorBody(message: '${e.message}');
      //         }
      //         return const _ErrorBody(
      //             message: "Oops, something unexpected happened");
      //       },
      //       loading: () => const Center(child: CircularProgressIndicator()),
      //       data: (movies) {
      //         return RefreshIndicator(
      //           onRefresh: () async {
      //             return ref.refresh(moviesFutureProvider);
      //           },
      //           child: GridView.extent(
      //             maxCrossAxisExtent: 200,
      //             crossAxisSpacing: 12,
      //             mainAxisSpacing: 12,
      //             childAspectRatio: 0.7,
      //             children:
      //                 movies.map((movie) => _MovieBox(movie: movie)).toList(),
      //           ),
      //         );
      //       },
      //     ),
    );
  }
}

Widget _buildLoadingWidget() {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Text("Loading data from API..."), CircularProgressIndicator()],
  ));
}

Widget _buildErrorWidget(String error) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Error occured: $error"),
    ],
  ));
}

class _ErrorBody extends ConsumerWidget {
  const _ErrorBody({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: () => ref.refresh(moviesFutureProvider),
            child: const Text("Try again"),
          ),
        ],
      ),
    );
  }
}

class _MovieBox extends StatelessWidget {
  final Movie movie;

  const _MovieBox({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          movie.poster,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
        Positioned(
          top: 5,
          right: 5,
          child: _FrontBanner1(text: movie.genre),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: _FrontBanner(text: movie.title),
        ),
      ],
    );
  }
}

class _FrontBanner extends StatelessWidget {
  const _FrontBanner({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.shade200.withOpacity(0.5),
          height: 40,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _FrontBanner1 extends StatelessWidget {
  const _FrontBanner1({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.grey.shade200.withOpacity(0.5),
          height: 30,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
