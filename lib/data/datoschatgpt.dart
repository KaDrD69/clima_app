// class Weather {
//   final String description;
//   final double temperature;

//   Weather({required this.description, required this.temperature});

//   factory Weather.fromJson(Map<String, dynamic> json) {
//     return Weather(
//       description: json['weather'][0]['description'],
//       temperature: json['main']['temp'].toDouble(),
//     );
//   }
// }
// 6. Haz una solicitud HTTP para obtener los datos
// dart
// Copiar
// Editar
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'weather.dart'; // tu modelo

// Future<Weather> fetchWeather(String city) async {
//   final apiKey = 'TU_API_KEY';
//   final url =
//       'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     return Weather.fromJson(data);
//   } else {
//     throw Exception('Error al cargar el clima');
//   }
// }
// 7. Usa fetchWeather() en tu interfaz Flutter
// Puedes llamarlo en initState() o desde un botón y mostrar los datos con FutureBuilder.

// dart
// Copiar
// Editar
// FutureBuilder<Weather>(
//   future: fetchWeather("Buenos Aires"),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else if (snapshot.hasData) {
//       final weather = snapshot.data!;
//       return Text(
//         'Clima: ${weather.description}, Temp: ${weather.temperature}°C',
//       );
//     } else {
//       return Text('No hay datos');
//     }
//   },
// )