class ClimaResponse {
  final String description;
  final double termica;
  final double temp;
  final double tempmin;
  final double tempmax;
  final double tempmin1;
  final double tempmin2;
  final double tempmin3;
  final double tempmax1;
  final double tempmax2;
  final double tempmax3;
  final double maxWindDia1;
  final double maxWindDia2;
  final double maxWindDia3;
  final double speedW;
  final double uv;
  final int humedad;
  final int localTimeEpoch;
  final int esDia;
  final String amanecer;
  final String atardecer;
  final String localTime;
  final String ciudad;
  final int fecha1;
  final int fecha2;
  final int fecha3;


  ClimaResponse({
    required this.description,
    required this.uv,
    required this.humedad,
    required this.termica,
    required this.temp,
    required this.tempmin,
    required this.tempmax,
    required this.tempmin1,
    required this.tempmin2,
    required this.tempmin3,
    required this.tempmax1,
    required this.tempmax2,
    required this.tempmax3,
    required this.maxWindDia1,
    required this.maxWindDia2,
    required this.maxWindDia3,
    required this.speedW,
    required this.localTimeEpoch,
    required this.esDia,
    required this.localTime,
    required this.ciudad,
    required this.fecha1,
    required this.fecha2,
    required this.fecha3,
    required this.amanecer,
    required this.atardecer,
  });

  factory ClimaResponse.fromJson(Map<String, dynamic> json) {
    return ClimaResponse(
      description: json["current"]["condition"]["text"] as String,
      uv: json["current"]["uv"] as double,
      //desActual: json["weather"][0]["main"],
      humedad: json["current"]["humidity"] as int,
      termica: json["current"]["feelslike_c"] as double,
      temp: json["current"]["temp_c"] as double,
      tempmin: json["forecast"]["forecastday"][0]["day"]["mintemp_c"] as double,
      tempmax: json["forecast"]["forecastday"][0]["day"]["maxtemp_c"] as double,
      speedW: json["current"]["wind_kph"] as double,
//      amanacer: json["sys"]["sunrise"] as int,
//      atardecer: json["sys"]["sunset"] as int,
//      id: json["weather"][0]["id"] as int,
      localTime: json["location"]["localtime"] as String,
      localTimeEpoch: json["location"]["localtime_epoch"] as int,
      ciudad: json["location"]["name"] as String,
      esDia: json["current"]["is_day"] as int,
      tempmin1: json["forecast"]["forecastday"][1]["day"]["mintemp_c"] as double,
      tempmin2: json["forecast"]["forecastday"][2]["day"]["mintemp_c"] as double,
      tempmin3: json["forecast"]["forecastday"][3]["day"]["mintemp_c"] as double,
      tempmax1: json["forecast"]["forecastday"][1]["day"]["maxtemp_c"] as double,
      tempmax2: json["forecast"]["forecastday"][2]["day"]["maxtemp_c"] as double,
      tempmax3: json["forecast"]["forecastday"][3]["day"]["maxtemp_c"] as double,
      maxWindDia1: json["forecast"]["forecastday"][1]["day"]["maxwind_kph"] as double,
      maxWindDia2: json["forecast"]["forecastday"][2]["day"]["maxwind_kph"] as double,
      maxWindDia3: json["forecast"]["forecastday"][3]["day"]["maxwind_kph"] as double,
      fecha1: json["forecast"]["forecastday"][1]["date_epoch"] as int,
      fecha2: json["forecast"]["forecastday"][2]["date_epoch"] as int,
      fecha3: json["forecast"]["forecastday"][3]["date_epoch"] as int,
      amanecer: json["forecast"]["forecastday"][0]["astro"]["sunrise"] as String,     
      atardecer: json["forecast"]["forecastday"][0]["astro"]["sunset"] as String,     
    );
  }
}
