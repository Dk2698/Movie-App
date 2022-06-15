import 'package:app_movie/http_helper.dart';
import 'package:app_movie/movie_detail.dart';
import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String? result = "";
  late HttpHelper helper;
  int? moviesCount;
  late List movies;

  final String iconBase = 'https://image.tmdb.org/t/p/w92/';
  final String defaultImage =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Future initialize() async {
    movies = [];
    movies = (await helper.getUpcoming())!;
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  // search
  Icon visibleIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Movies');
  Future search(text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
      print(movies);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // helper.getUpcoming().then((value) {
    //   setState(() {
    //     result = value as String?;
    //     print(result);
    //   });
    // });

    NetworkImage image;
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (visibleIcon.icon == Icons.search) {
                  visibleIcon = const Icon(Icons.cancel);
                  searchBar = TextField(
                    onSubmitted: (String text) {
                      search(text);
                    },
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                } else {
                  setState(() {
                    visibleIcon = const Icon(Icons.search);
                    searchBar = const Text('Movies');
                  });
                }
              });
            },
            icon: visibleIcon,
          )
        ],
      ),
      body: ListView.builder(
          itemCount: (moviesCount) == null ? 0 : moviesCount,
          itemBuilder: (BuildContext context, int position) {
            if (movies[position].posterPath != null) {
              image = NetworkImage(iconBase + movies[position].posterPath);
            } else {
              image = NetworkImage(defaultImage);
            }
            return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movie: movies[position]));
                  Navigator.push(context, route);
                },
                title: Text(movies[position].title!),
                subtitle: Text('Released:' +
                    movies[position].releaseDate! +
                    '- Vote: ' +
                    movies[position].voteAverage.toString()),
                leading: CircleAvatar(backgroundImage: image),
              ),
            );
          }),
    );
  }
}
