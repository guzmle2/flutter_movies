import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie_models.dart';
import 'package:flutter_movies/src/providers/movies_providers.dart';

class DataSearch extends SearchDelegate {
  final movies = [];
  final moviesRecents = ['spider', 'capitan america', 'batman', 'Super girl'];
  final moviesProviders = new MoviesProviders();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

//  @override
//  Widget buildSuggestions(BuildContext context) {
//    List<dynamic> listFilter = moviesRecents;
//    if (query.isNotEmpty) {
//      listFilter = moviesRecents
//          .where((f) => f.toLowerCase().startsWith(query.toLowerCase()))
//          .toList(); //apples
//    }
//
//    return ListView.builder(
//      itemBuilder: (context, i) {
//        return ListTile(
//          leading: Icon(Icons.movie),
//          title: Text(listFilter[i]),
//          onTap: () {},
//        );
//      },
//      itemCount: listFilter.length,
//    );
//  }
  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: moviesProviders.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Movie> movies = snapshot.data;
          return ListView(
            children: movies.map((movie) {
              movie.uniqueId = '';
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.contain,
                  width: 50.0,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.original_title),
                onTap: () =>
                    Navigator.pushNamed(context, 'detail', arguments: movie),
              );
            }).toList(),
          );
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
