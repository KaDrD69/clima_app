import 'dart:async';
import 'package:clima_app/data/icons_weather.dart';
import 'package:clima_app/data/repository.dart';

class ClimaBloc {
  final _climaController = StreamController();

  final int _fecha = 0;

  Stream get stream => _climaController.stream;

  Future<void> cargarClima() async {
    final repo = Repository();
    final clima = await repo.fetchClima();
    final climaForecast = await repo.fetchClimaForecast();

    DateTime fecha = DateTime.fromMillisecondsSinceEpoch(clima!.dt*1000); 
    print(fecha);
    // for(var item in climaForecast!.lista){

    //   print(item["dt_txt"]);
    // }


    if (clima != null && climaForecast != null) {
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
      });
    } else {
      _climaController.sink.add({
      //  "fecha": climaForecast?.fecha ?? _fecha,
        "temp": 0,
        "tempmin": 0,
        "tempmax": 0,
        "humedad": 0,
        "viento": 0,
        "des": "",
        "desActual": "",
        "dianoche": "",
        "ciudad": "",
      });
    }

    // if (clima != null) {
    //   _temp = clima.temp;
    //   _humedad = clima.humedad;
    //   _viento = clima.speedW;
    //   _tempmin = clima.tempmin;
    //   _tempmax = clima.tempmax;
    //   _des = clima.description;
    //   _desActual = clima.desActual;
    //   //_id = clima.id;
    //   _dt = clima.dt;
    //   _ciudad = clima.ciudad;
    //   if (_dt >= clima.amanacer && _dt < clima.atardecer) {
    //     _dianoche = "dia";
    //   } else {
    //     _dianoche = "noche";
    //   }

    //   //  _icono = obtenerIcono(_dianoche, _id);
    //   _climaController.sink.add({
    //     "temp": _temp,
    //     "tempmin": _tempmin,
    //     "tempmax": _tempmax,
    //     "humedad": _humedad,
    //     "viento": _viento,
    //     "des": _des,
    //     "desActual": _desActual,
    //     //  "icono": _icono,
    //     "dianoche": _dianoche,
    //     "ciudad": _ciudad,
    //   });
    // }
  }

  void dispose() {
    _climaController.close();
  }
}
