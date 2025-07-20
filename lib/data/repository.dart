import 'dart:convert';
import 'package:clima_app/data/mi_data.dart';
import 'package:clima_app/data/model/clima_response.dart';
import 'package:clima_app/data/model/clima_response_forecast.dart';
import 'package:http/http.dart' as http;

class Repository {

  Future<ClimaResponse?> fetchClima() async {
    const String ciudad = "Punta Arenas";
    //final response = await http.get(Uri.parse('https://www.google.com'));
    //print('Status code Google: ${response.statusCode}');
    //final urlNow = "https://api.openweathermap.org/data/2.5/weather?q=$ciudad&appid=${ApiKey.apiKey2}&units=metric&lang=es";
    //final urlNow = "https://api.weatherapi.com/v1/current.json?key=${ApiKey.apiKey3}&q=$ciudad&lang=es";
    final urlNow = "https://api.weatherapi.com/v1/forecast.json?key=${ApiKey.apiKey3}&q=$ciudad&lang=es&days=4";
    final responseNow = await http.get(Uri.parse(urlNow));
    
    if(responseNow.statusCode == 200){
      var decodeJson = jsonDecode(responseNow.body);
      ClimaResponse climaResponse = ClimaResponse.fromJson(decodeJson);
      return climaResponse;

    }else{
      return null;
    }
  }

  // Future<ClimaResponseForecast?> fetchClimaForecast() async {
  //   const String ciudad = "Punta Arenas";

  //   //final urlForecast = "https://api.openweathermap.org/data/2.5/forecast?q=$ciudad&appid=${ApiKey.apiKey2}&units=metric&lang=es";    
  //   final urlForecast = "https://api.weatherapi.com/v1/forecast.json?key=${ApiKey.apiKey3}&q=$ciudad&lang=es";
  //   final responseForecast = await http.get(Uri.parse(urlForecast));
    
  //   if(responseForecast.statusCode == 200){
  //     var decodeJson = jsonDecode(responseForecast.body);
  //     ClimaResponseForecast climaResponseForecast = ClimaResponseForecast.fromJson(decodeJson);
  //     return climaResponseForecast;

  //   }else{
  //     return null;
  //   }

  // }
}