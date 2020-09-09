import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/provider/pelicula_provider.dart';
import 'package:peliculas/src/search/search_data.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';
import 'package:peliculas/src/widgets/swiper_widget.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas de cine'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {
              showSearch(
                context: context,
                delegate: SearchData(),
              )
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _swiper(),
          _footer(context),
        ],
      ),
    );
  }

  Widget _swiper() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.data != null) {
          return CardWidget(peliculas: snapshot.data);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );

    //return CardWidget(peliculas: [1, 2, 3, 4, 5]);
  }

  Widget _footer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Populares',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(height: 5.0),
        StreamBuilder(
          stream: peliculasProvider.popularesStream,
          //initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return MovieHorizontal(
                peliculas: snapshot.data,
                cargarMasPopulares: peliculasProvider.getPopulares,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        // FutureBuilder(
        //   future: peliculasProvider.getPopulares(),
        //   //initialData: InitialData,
        //   builder: (BuildContext context, AsyncSnapshot snapshot) {
        //     if (snapshot.hasData) {
        //       return MovieHorizontal(
        //         peliculas: snapshot.data,
        //       );
        //     } else {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
      ],
    );
  }
}
