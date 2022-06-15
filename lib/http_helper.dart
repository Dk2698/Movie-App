import 'dart:convert';

import 'package:app_movie/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HttpHelper {
  final String urlkey = "api_key=0baa01ca39e02e26ca12d93b92a9cfc7";
  final String urlBase = "https://api.themoviedb.org/3/movie";
  final String urlUpcoming = "/upcoming?";
  // final String urlLanguage = '&language=en-US';
  final String urlSearchBase =
      "https://api.themoviedb.org/3/search/movie/?api_key=0baa01ca39e02e26ca12d93b92a9cfc7&query=";
  Future<List?> getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlkey;
    // print(upcoming);
    http.Response result = await http.get(Uri.parse(upcoming));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      // print(jsonResponse);
      final moviesMap = jsonResponse['results'];
      // print(moviesMap);
      // convert to model and in list
      List movies = moviesMap.map((e) => Movie.fromJson(e)).toList();
      return movies;
    } else {
      return [];
    }
  }

  Future<List> findMovies(String title) async {
    final String query = urlSearchBase + title;
    print(query);
    http.Response result = await http.get(Uri.parse(query));
    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      // print(jsonResponse);
      final moviesMap = jsonResponse['results'];
      print(moviesMap);
      // convert to model and in list
      List movies = moviesMap.map((e) => Movie.fromJson(e)).toList();
      return movies;
    } else {
      return [];
    }
  }
}
