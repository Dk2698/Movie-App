import 'package:app_movie/movie_list.dart';
import 'package:flutter/material.dart';

class MyMovies extends StatelessWidget {
  const MyMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' My Movies',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MovieList();
  }
}
