class ClimaResponse {
  final String description;
  final double temp;
  final int amanacer;
  final int atardecer;

  ClimaResponse({required this.description, required this.temp, required this.amanacer, required this.atardecer});


  factory ClimaResponse.fromJson(Map<String, dynamic> json){
    return ClimaResponse(
      description: json["weather"][0]["description"],
      temp: json["main"]["temp"] as double,
      amanacer: json["sys"]["sunrise"] as int,
      atardecer: json["sys"]["sunset"] as int
    );
  }


}