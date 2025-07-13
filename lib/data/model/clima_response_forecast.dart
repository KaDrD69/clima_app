class ClimaResponseForecast {
  final int fecha;
//  final List lista;

  ClimaResponseForecast({
    required this.fecha,
//    required this.lista,
  });
  

  factory ClimaResponseForecast.fromJson(Map<String, dynamic> json){
    for (dynamic lista in json["list"]){
      print(lista);
    }
    return ClimaResponseForecast(
      fecha: json["list"][2]["dt"] as int,
    );
  }
}