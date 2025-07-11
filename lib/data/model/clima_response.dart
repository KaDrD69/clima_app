class ClimaResponse {
  final String description;
  final double temp;
  final double tempmin;
  final double tempmax;
  final int amanacer;
  final int atardecer;
  final int id;
  final int dt;
  final String ciudad;
  

  ClimaResponse({
    required this.description,
    required this.temp,
    required this.tempmin,
    required this.tempmax,
    required this.amanacer,
    required this.atardecer,
    required this.id,
    required this.dt,
    required this.ciudad,
  });

  factory ClimaResponse.fromJson(Map<String, dynamic> json) {
    return ClimaResponse(
      description: json["weather"][0]["description"],
      temp: json["main"]["temp"] as double,
      tempmin: json["main"]["temp_min"] as double,
      tempmax: json["main"]["temp_max"] as double,
      amanacer: json["sys"]["sunrise"] as int,
      atardecer: json["sys"]["sunset"] as int,
      id: json["weather"][0]["id"] as int,
      dt: json["dt"] as int,
      ciudad: json["name"] as String,
    );
  }
}
