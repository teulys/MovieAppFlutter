import 'package:flutter/material.dart';
import 'package:peliculas/src/model/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );
  final Function cargarMasPopulares;

  MovieHorizontal(
      {@required this.peliculas, @required this.cargarMasPopulares});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        cargarMasPopulares();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child:
          // PageView(
          //   controller: _pageController,
          //   children: _listaPeliculas(),
          // ),
          PageView.builder(
        controller: _pageController,
        itemCount: peliculas.length,
        pageSnapping: false,
        itemBuilder: (context, i) {
          return getPelicula(context, peliculas[i]);
        },
      ),
    );
  }

  Widget getPelicula(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-tarjeta';

    var tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Hero(
        tag: pelicula.uniqueId,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160.0,
              image: NetworkImage(pelicula.getPosterImg())),
        ),
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  List<Widget> _listaPeliculas() {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              fit: BoxFit.cover,
              height: 160.0,
              image: NetworkImage(pelicula.getPosterImg())),
        ),
      );
    }).toList();
  }
}
