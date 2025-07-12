class ClimaResponseForecast {
  final String fecha;

  ClimaResponseForecast({
    required this.fecha,
  });

  factory ClimaResponseForecast.fromJson(Map<String, dynamic> json){
    return ClimaResponseForecast(
      fecha: json["list"]["2"]["dt_txt"] as String,
    );
  }
}