import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/model/peliculas_model.dart';

class CardWidget extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardWidget({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.5,
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-poster';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'detalle',
                  arguments: peliculas[index]),
              child: ClipRRect(
                child: FadeInImage(
                  image: NetworkImage(
                    peliculas[index].getPosterImg(),
                  ),
                  fit: BoxFit.fill,
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          );
        },
        itemCount: peliculas.length,
        itemHeight: _screenSize.height * 0.5,
        itemWidth: _screenSize.width * 0.7,
        layout: SwiperLayout.STACK,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}
