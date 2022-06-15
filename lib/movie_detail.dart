// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_movie/movie.dart';

import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  const MovieDetail({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String imgPath = 'https://image.tmdb.org/t/p/w500/';
    String path;
    if (movie.posterPath != null) {
      path = imgPath + movie.posterPath!;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title!),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: height / 1.5,
                child: Image.network(path),
              ),
              Container(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: Text(movie.overview!),
              )
            ],
          ),
        ),
      ),
    );
  }
}
