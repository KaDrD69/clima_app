class ClimaResponse {
  final String description;
//  final String desActual;
  final double termica;
  final double temp;
//  final double tempmin;
//  final double tempmax;
  final double speedW;
  final int humedad;
  final int localTimeEpoch;
  final int esDia;
//  final int amanacer;
//  final int atardecer;
//  final int id;
  final String localTime;
  final String ciudad;

  ClimaResponse({
    required this.description,
//    required this.desActual,
    required this.humedad,
    required this.termica,
    required this.temp,
//    required this.tempmin,
//    required this.tempmax,
    required this.speedW,
    required this.localTimeEpoch,
    required this.esDia,
//    required this.amanacer,
//    required this.atardecer,
//    required this.id,
    required this.localTime,
    required this.ciudad,
  });

  factory ClimaResponse.fromJson(Map<String, dynamic> json) {
    return ClimaResponse(
      description: json["current"]["condition"]["text"] as String,
      //desActual: json["weather"][0]["main"],
      humedad: json["current"]["humidity"] as int,
      termica: json["current"]["feelslike_c"] as double,
      temp: json["current"]["temp_c"] as double,
      //tempmin: json["main"]["temp_min"] as double,
      //tempmax: json["main"]["temp_max"] as double,
      speedW: json["current"]["wind_kph"] as double,
//      amanacer: json["sys"]["sunrise"] as int,
//      atardecer: json["sys"]["sunset"] as int,
//      id: json["weather"][0]["id"] as int,
      localTime: json["location"]["localtime"] as String,
      localTimeEpoch: json["location"]["localtime_epoch"] as int,
      ciudad: json["location"]["name"] as String,
      esDia: json["current"]["is_day"] as int,
    );
  }
}
