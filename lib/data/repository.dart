import 'dart:convert';
import 'package:clima_app/data/mi_data.dart';
import 'package:clima_app/data/model/clima_response.dart';
import 'package:http/http.dart' as http;

class Repository {

  Future<ClimaResponse?> fetchClima() async {
    const String ciudad = "Punta Arenas";
    final url = "https://api.openweathermap.org/data/2.5/weather?q=$ciudad&appid=${ApiKey.apiKey}&units=metric";
    final response = await http.get(Uri.parse(url));
    

    if(response.statusCode == 200){
      var decodeJson = jsonDecode(response.body);
      ClimaResponse climaResponse = ClimaResponse.fromJson(decodeJson);
      return climaResponse;

    }else{
      return null;
    }
  }
}