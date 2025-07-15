import 'dart:async';
import 'package:clima_app/data/icons_weather.dart';
import 'package:clima_app/data/repository.dart';

//sin paquetes extras solo usamos StreamController

class ClimaBloc {
  final _climaController = StreamController();

  String _diaSemana = "";
  double _tempFutura = 0;

  final Map<int, String> _diaNombre = {
    1: "Lunes",
    2: "Martes",
    3: "Miercoles",
    4: "Jueves",
    5: "Viernes",
    6: "Sábado",
    7: "Domingo",
  };

  final List<Map<String, double>> _pronostico = [];

  Stream get stream => _climaController.stream;

  Future<void> cargarClima() async {
    _pronostico.clear();

    final repo = Repository();
    final clima = await repo.fetchClima();
    final climaForecast = await repo.fetchClimaForecast();

    if (clima == null || climaForecast == null) {
      _climaController.sink.add({
        "temp": 0,
        "tempmin": 0,
        "tempmax": 0,
        "humedad": 0,
        "viento": 0,
        "des": "",
        "desActual": "",
        "dianoche": "",
        "ciudad": "",
        "nombreDia1": "",
        "nombreDia2": "",
        "nombreDia3": "",
        "tempDia1": 0,
        "tempDia2": 0,
        "tempDia3": 0,
      });
      return;
    }

    DateTime fecha = DateTime.fromMillisecondsSinceEpoch(
      clima.dt * 1000,
      isUtc: true,
    );

    for (var item in climaForecast.lista) {
      DateTime fecha2 = DateTime.fromMillisecondsSinceEpoch(
        item["dt"] * 1000,
        isUtc: true,
      );
      if (fecha2.hour == 12 && fecha.day != fecha2.day) {
        _diaSemana = _diaNombre[fecha2.weekday] ?? "Sin dato";
        _tempFutura = item["main"]["temp"] ?? 0;
        _pronostico.add({_diaSemana: _tempFutura});
      }
    }
    print(_pronostico);

    _climaController.sink.add({
      //"fecha": climaForecast.fecha,
      "temp": clima.temp,
      "tempmin": clima.tempmin,
      "tempmax": clima.tempmax,
      "humedad": clima.humedad,
      "viento": clima.speedW,
      "des": clima.description,
      "dt": clima.dt,
      "ciudad": clima.ciudad,
      "dianoche": clima.dt >= clima.amanacer && clima.dt < clima.atardecer
          ? "dia"
          : "noche",
      "nombreDia1": _pronostico[0].keys.first,
      "nombreDia2": _pronostico[1].keys.first,
      "nombreDia3": _pronostico[2].keys.first,
      "tempDia1": _pronostico[0].values.first,
      "tempDia2": _pronostico[1].values.first,
      "tempDia3": _pronostico[2].values.first,
    });

  }

  void dispose() {
    _climaController.close();
  }
}
