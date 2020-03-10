import 'package:flutter/material.dart';
import 'package:flutter_movies/src/delegate/search_delegate.dart';
import 'package:flutter_movies/src/providers/movies_providers.dart';
import 'package:flutter_movies/src/widgets/card_swiper_widget.dart';
import 'package:flutter_movies/src/widgets/movies_horizontal_widget.dart';

class HomePage extends StatelessWidget {
  final movieProviders = new MoviesProviders();

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    movieProviders.getPopulars();

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies in cinema'),
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearch(),
              );
            },
          )
        ],
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _swiperCards(context),
          _footer(context),
        ],
      )),
    );
  }

  Widget _swiperCards(BuildContext context) {
    return FutureBuilder(
      future: movieProviders.getCinema(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? CardSwiper(
                movies: snapshot.data,
              )
            : Container(
                height: 400.0,
                child: Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Popular',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(height: 30.0),
          StreamBuilder(
            stream: movieProviders.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return snapshot.hasData
                  ? MovieHorizontal(
                      movies: snapshot.data,
                      nextPage: movieProviders.getPopulars,
                    )
                  : Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
    );
  }
}
