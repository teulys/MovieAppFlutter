import 'package:flutter/material.dart';
import 'package:peliculas/src/model/actores_model.dart';
import 'package:peliculas/src/model/peliculas_model.dart';
import 'package:peliculas/src/provider/pelicula_provider.dart';

class DetallePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _getSliverBar(pelicula),
        SliverList(
          delegate: SliverChildListDelegate([
            SizedBox(height: 10.0),
            _getTitle(pelicula),
            SizedBox(height: 10.0),
            _getDetails(pelicula),
            SizedBox(height: 10.0),
            _getDetails(pelicula),
            SizedBox(height: 10.0),
            _getDetails(pelicula),
            _getActores(pelicula),
          ]),
        ),
        //_getTitle(pelicula),
      ],
    ));
  }

  Widget _getSliverBar(Pelicula pelicula) {
    return SliverAppBar(
        expandedHeight: 250.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            pelicula.title,
            style: TextStyle(fontSize: 13.0),
          ),
          background: FadeInImage(
            image: NetworkImage(pelicula.getBackgroundImg()),
            placeholder: AssetImage('assets/img/loading.gif'),
            fit: BoxFit.cover,
          ),
        ));
  }

  Widget _getTitle(Pelicula pelicula) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      height: 150.0,
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(image: NetworkImage(pelicula.getPosterImg())),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title),
                Row(
                  children: [
                    Text(pelicula.voteAverage.toString()),
                    Icon(Icons.star_border),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _getDetails(Pelicula pelicula) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _getActores(Pelicula pelicula) {
    final actorProvider = PeliculaProvider();

    return FutureBuilder(
      future: actorProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _getActoresPage(snapshot.data);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget _getActoresPage(Actores actores) {
    return Container(
      height: 180.0,
      child: PageView.builder(
        itemCount: actores.cast.length,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        pageSnapping: false,
        itemBuilder: (context, i) {
          return _getActorContainer(actores.cast[i]);
        },
      ),
    );
  }

  Widget _getActorContainer(Cast cast) {
    return Container(
        child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            height: 150.0,
            placeholder: AssetImage('assets/img/no-image.jpg'),
            image: NetworkImage(
              cast.getPhoto(),
            ),
            fit: BoxFit.cover,
          ),
        ),
        Text(
          cast.name,
          overflow: TextOverflow.ellipsis,
        )
      ],
    ));
  }
}
