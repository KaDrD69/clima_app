class ClimaResponseForecast {
  final List<Map<String, dynamic>> lista;

  ClimaResponseForecast({
    required this.lista,
  });
  

  factory ClimaResponseForecast.fromJson(Map<String, dynamic> json){
    final listaLimpia = List<Map<String, dynamic>>.from(json["list"]);
    return ClimaResponseForecast(
      lista: listaLimpia,
    );
  }
}