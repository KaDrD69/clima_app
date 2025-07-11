import 'dart:async';
import 'package:clima_app/data/icons_weather.dart';
import 'package:clima_app/data/repository.dart';

class ClimaBloc {
  final _climaController = StreamController();
  double _temp = 0;
  double _viento = 0;
  double _tempmin = 0;
  double _tempmax = 0;
  String _des = "";
  int _humedad = 0;
  int _id = 0;
  int _dt = 0;
  String _icono = "";
  String _dianoche = "";
  String _ciudad = "";

  Stream get stream => _climaController.stream;

  Future<void> cargarClima() async {
    final repo = Repository();
    final clima = await repo.fetchClima();

    if (clima != null){    
        _temp = clima.temp;
        _humedad = clima.humedad;
        _viento = clima.speedW;
        _tempmin = clima.tempmin;
        _tempmax = clima.tempmax;
        _des = clima.description;
        //_id = clima.id;
        _dt = clima.dt;
        _ciudad = clima.ciudad;
        if (_dt >= clima.amanacer && _dt < clima.atardecer){
          _dianoche = "dia";
        } else {
          _dianoche = "noche";
        }
      //  _icono = obtenerIcono(_dianoche, _id);
        _climaController.sink.add({
          "temp": _temp,
          "tempmin": _tempmin,
          "tempmax": _tempmax,
          "humedad": _humedad,
          "viento" : _viento,
          "des": _des,
        //  "icono": _icono,
          "dianoche": _dianoche,
          "ciudad": _ciudad,
        });
     
    }
  }

  void dispose() {
  _climaController.close();
  }
}