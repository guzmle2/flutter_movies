import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/actor_models.dart';
import 'package:flutter_movies/src/models/movie_models.dart';
import 'package:flutter_movies/src/providers/movies_providers.dart';

class MovieDetailPage extends StatelessWidget {
  MovieDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _posterTitle(context, movie),
              _description(context, movie),
              SizedBox(
                height: 10.0,
              ),
              _casting(context, movie),
            ]),
          )
        ],
      ),
    );
  }

  _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.deepOrangeAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
          height: 200.0,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(movie.getPosterImg()),
                height: 150.0,
              ),
            ),
            tag: movie.uniqueId,
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  movie.title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.original_title,
                  style: Theme
                      .of(context)
                      .textTheme
                      .subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.vote_average.toString())
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  _description(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  _casting(BuildContext context, Movie movie) {
    final movieProviders = new MoviesProviders();

    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Actors',
              style: Theme
                  .of(context)
                  .textTheme
                  .subhead,
            ),
          ),
          SizedBox(height: 30.0),
          FutureBuilder(
            future: movieProviders.getCast(movie.id.toString()),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return snapshot.hasData
                  ? _carActoresPageView(snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }

  _carActoresPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1,
        ),
        itemCount: actors.length,
        itemBuilder: (BuildContext context, i) => _actorCard(actors[i]),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getAvatar()),
              placeholder: AssetImage('assets/img/loading.gif'),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
