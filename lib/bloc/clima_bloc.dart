import 'dart:async';
import 'package:clima_app/data/icons_weather.dart';
import 'package:clima_app/data/repository.dart';

//sin paquetes extras solo usamos StreamController

class ClimaBloc {
  final _climaController = StreamController();
  final _ciudadController = StreamController();
  final repo = Repository();

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

  final List<Map<String, dynamic>> _pronostico = [];

  Stream get stream => _climaController.stream;
  Sink get ciudadSink => _ciudadController.sink;

  ClimaBloc() {
    _ciudadController.stream.listen((ciudad) {
      cargarClima(ciudad: ciudad);
    });
    cargarClima();
  }

  Future<void> cargarClima({String ciudad = "Punta Arenas"}) async {
    _pronostico.clear();

    final clima = await repo.fetchClima(ciudad);

    //    final climaForecast = await repo.fetchClimaForecast();

    if (clima == null) {
      _climaController.sink.add({
        "fecha": "",
        "uv": 0,
        "temp": 0,
        "terminca": 0,
        "tempmin": 0,
        "tempmax": 0,
        "humedad": 0,
        "viento": 0,
        "des": "",
        "esdia": 1,
        "ciudad": "",
        "nombreDia1": "",
        "nombreDia2": "",
        "nombreDia3": "",
        "tempminDia1": 0,
        "tempminDia2": 0,
        "tempminDia3": 0,
        "tempmaxDia1": 0,
        "tempmaxDia2": 0,
        "tempmaxDia3": 0,
        "maxWindDia1": 0,
        "maxWindDia2": 0,
        "maxWindDia3": 0,
        "amanecer": "",
        "atardecer": ""
      });
      return;
    }

    DateTime fecha = DateTime.fromMillisecondsSinceEpoch(
      clima.localTimeEpoch * 1000,
      isUtc: true,
    );
    DateTime fecha1 = DateTime.fromMillisecondsSinceEpoch(
      clima.fecha1 * 1000,
      isUtc: true,
    );
    DateTime fecha2 = DateTime.fromMillisecondsSinceEpoch(
      clima.fecha2 * 1000,
      isUtc: true,
    );
    DateTime fecha3 = DateTime.fromMillisecondsSinceEpoch(
      clima.fecha3 * 1000,
      isUtc: true,
    );

    // for (var item in climaForecast.lista) {
    //   DateTime fecha2 = DateTime.fromMillisecondsSinceEpoch(
    //     item["dt"] * 1000,
    //     isUtc: true,
    //   );
    //   if (fecha2.hour == 12 && fecha.day != fecha2.day) {
    //     _diaSemana = _diaNombre[fecha2.weekday] ?? "Sin dato";
    //     _tempFutura = (item["main"]["temp"] as num).toDouble();
    //     _pronostico.add({_diaSemana: _tempFutura});
    //   }
    // // }
    // print(_pronostico);

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
      "viento": clima.speedW.toStringAsFixed(0),
      "des": clima.description,
      "esdia": clima.esDia,
      "uv": clima.uv,
      //"desActual": clima.desActual,
      //"dt": clima.dt,
      "ciudad": clima.ciudad,
      // "dianoche": clima.dt >= clima.amanacer && clima.dt < clima.atardecer
      //     ? "dia"
      //     : "noche",
      "nombreDia1": _diaNombre[fecha1.weekday],
      "nombreDia2": _diaNombre[fecha2.weekday],
      "nombreDia3": _diaNombre[fecha3.weekday],
      "tempminDia1": clima.tempmin1.toStringAsFixed(0) == "-0"
          ? "0"
          : clima.tempmin1.toStringAsFixed(0),
      "tempminDia2": clima.tempmin2.toStringAsFixed(0) == "-0"
          ? "0"
          : clima.tempmin2.toStringAsFixed(0),
      "tempminDia3": clima.tempmin3.toStringAsFixed(0) == "-0"
          ? "0"
          : clima.tempmin3.toStringAsFixed(0),
      "tempmaxDia1": clima.tempmax1.toStringAsFixed(0) == "-0"
          ? "0"
          : clima.tempmax1.toStringAsFixed(0),
      "tempmaxDia2": clima.tempmax2.toStringAsFixed(0) == "-0"
          ? "0"
          : clima.tempmax2.toStringAsFixed(0),
      "tempmaxDia3": clima.tempmax3.toStringAsFixed(0) == "-0"
          ? "0"
          : clima.tempmax3.toStringAsFixed(0),
      "maxWindDia1": clima.maxWindDia1.toStringAsFixed(0),
      "maxWindDia2": clima.maxWindDia2.toStringAsFixed(0),
      "maxWindDia3": clima.maxWindDia3.toStringAsFixed(0),
      "amanecer": clima.amanecer,
      "atardecer": clima.atardecer
    });
  }

  void dispose() {
    _climaController.close();
    _ciudadController.close();
  }
}
