import 'package:flutter/material.dart';
import 'package:peliculas/src/model/peliculas_model.dart';
import 'package:peliculas/src/provider/pelicula_provider.dart';

class SearchData extends SearchDelegate {
  final _peliculasSugeridas = [
    'Superman',
    'Spiderman',
    'Ironman',
    'Ironman 2',
    'Ironman 3',
    'Ironman 4',
  ];

  List<String> _peliculasFiltradas = [];

  final _peliculaProvider = PeliculaProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    //Botones de accion
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //Boton de la izquierda
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, query);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //Resultados
    throw Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Resultados sugeridos

    return FutureBuilder(
      future: _peliculaProvider.findPeliculas(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if (snapshot.hasData) {
          var pelicula = snapshot.data;

          return ListView(
            children: pelicula.map((e) {
              return ListTile(
                title: Text(e.title),
                subtitle: Text(e.originalTitle),
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(e.getPosterImg()),
                ),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'detalle', arguments: e);
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   //Resultados sugeridos

  //   _peliculasFiltradas = (query != '')
  //       ? _peliculasSugeridas
  //           .where((p) => p.toLowerCase().startsWith(query.toLowerCase()))
  //           .toList()
  //       : _peliculasSugeridas;

  //   return ListView.builder(
  //     itemCount: _peliculasFiltradas.length,
  //     itemBuilder: (context, i) {
  //       return ListTile(
  //         title: Text(_peliculasFiltradas[i]),
  //         leading: Icon(Icons.movie),
  //         onTap: () {},
  //       );
  //     },
  //   );
  // }
}
