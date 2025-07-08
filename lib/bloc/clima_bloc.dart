import 'dart:async';
import 'package:clima_app/data/icons_weather.dart';
import 'package:clima_app/data/repository.dart';

class ClimaBloc {
  final _climaController = StreamController();
  double _temp = 0;
  String _des = "";
  int _id = 0;
  String _icono = "";
  int _dt = 0;
  bool _esDia = true;

  Stream get stream => _climaController.stream;

  Future<void> cargarClima() async {
    final repo = Repository();
    final clima = await repo.fetchClima();

    if (clima != null){    
        _temp = clima.temp;
        _des = clima.description;
        _id = clima.id;
        _dt = clima.dt;
        if (_dt >= clima.amanacer && _dt < clima.atardecer){
          _esDia = true;
        } else {
          _esDia = false;
        }
        _icono = obtenerIcono(_esDia, _id);
        _climaController.sink.add({
          "temp": _temp,
          "des": _des,
          "icono": _icono,
          "esDia": _esDia,

        });
     
    }
  }

  void dispose() {
  _climaController.close();
  }
}