import 'dart:async';
import 'package:clima_app/data/icons_weather.dart';
import 'package:clima_app/data/repository.dart';

//sin paquetes extras solo usamos StreamController

class ClimaBloc {
  final _climaController = StreamController();

  String _diaSemana = "";
  double _tempFutura = 0;
  String _fecha = "";

  final Map<int, String> _diaNombre = {
    1: "Lunes",
    2: "Martes",
    3: "Miércoles",
    4: "Jueves",
    5: "Viernes",
    6: "Sábado",
    7: "Domingo",
  };
  final Map<int, String> _mesNombre = {
    1: "Enero",
    2: "Febrero",
    3: "Marzo",
    4: "Abril",
    5: "Mayo",
    6: "Junio",
    7: "Julio",
    8: "Agosto",
    9: "Septiembre",
    10: "Octubre",
    11: "Noviembre",
    12: "Diciembre",
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
        "fecha": "",
        "temp": 0,
        "terminca": 0,
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
      "fecha":
          "${_diaNombre[fecha.weekday]}, ${fecha.day} de ${_mesNombre[fecha.month]}",
      "temp": clima.temp.toStringAsFixed(0),
      "termica": clima.termica.toStringAsFixed(0) == "-0"
          ? "0"
          : clima.termica.toStringAsFixed(0),
      "tempmin": clima.tempmin.toStringAsFixed(0),
      "tempmax": clima.tempmax.toStringAsFixed(0),
      "humedad": clima.humedad.toStringAsFixed(0),
      "viento": clima.speedW,
      "des": clima.description,
      "desActual": clima.desActual,
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
