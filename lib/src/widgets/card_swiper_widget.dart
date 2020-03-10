import 'package:flutter/material.dart';
import 'package:flutter_movies/src/models/movie_models.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      child: Swiper(
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            movies[index].uniqueId = '${movies[index].id}-swiper';

            return Hero(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  child: FadeInImage(
                    image: NetworkImage(movies[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/loading.gif'),
                    fit: BoxFit.cover,
                  ),
                  onTap: () => Navigator.pushNamed(context, 'detail',
                      arguments: movies[index]),
                ),
              ),
              tag: movies[index].uniqueId,
            );
          },
          itemCount: movies.length,
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5),
    );
  }
}
