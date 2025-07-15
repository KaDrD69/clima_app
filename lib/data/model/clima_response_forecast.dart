class ClimaResponseForecast {
  final List<Map<String, dynamic>> lista;
  // final int dia2;
  // final int dia3;
  // final int dia4;
  // final int dia2Temp;
  // final int dia3Temp;
  // final int dia4Temp;

  ClimaResponseForecast({
    required this.lista,
    // required this.dia2,
    // required this.dia3,
    // required this.dia4,
    // required this.dia2Temp,
    // required this.dia3Temp,
    // required this.dia4Temp,
  });

  // final Map<int, String> _diaSemana = {
  //   1: "Lunes",
  //   2: "Martes",
  //   3: "Miercoles",
  //   4: "Jueves",
  //   5: "Viernes",
  //   6: "Sábado",
  //   7: "Domingo",
  // };

  factory ClimaResponseForecast.fromJson(Map<String, dynamic> json) {
    final listaLimpia = List<Map<String, dynamic>>.from(json["list"]);

    return ClimaResponseForecast(
      lista: listaLimpia,
    );
  }
}
