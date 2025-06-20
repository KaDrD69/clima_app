class ClimaResponse {
  final String description;
  final double temp;

  ClimaResponse({required this.description, required this.temp});


  factory ClimaResponse.fromJson(Map<String, dynamic> json){
    return ClimaResponse(
      description: json["weather"][0]["description"],
      temp: json["main"]["temp"] as double
    );
  }


}
