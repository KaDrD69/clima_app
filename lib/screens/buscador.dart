import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  final List<String> ciudades = [
    "Buenos Aires",
    "Barcelona",
    "Bogotá",
    "Caracas",
    "Lima",
    "Madrid",
    "México",
    "Montevideo",
    "Quito",
    "Santiago",
  ];

  final List<String> ciudadesRecientes = [
    "Buenos Aires",
    "Madrid",
    "Lima",
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // Botón de limpiar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpia el texto
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // Flecha de volver
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, ''); // Cierra el buscador
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Aquí puedes devolver una nueva pantalla, o hacer algo con la selección
    return Center(
      child: Text(
        "Has seleccionado: $query",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencias en tiempo real
    final suggestionList = query.isEmpty
        ? ciudadesRecientes
        : ciudades.where((c) => c.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final ciudad = suggestionList[index];
        return ListTile(
          title: RichText(
            text: TextSpan(
              text: ciudad.substring(0, query.length),
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              children: [
                TextSpan(
                  text: ciudad.substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          onTap: () {
            query = ciudad;
            showResults(context); // Muestra buildResults
          },
        );
      },
    );
  }
}
