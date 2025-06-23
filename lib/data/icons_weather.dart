String? ObtenerIcono(bool? dia, int? id){

  Map<int, dynamic> weatherIcons = {
    // Cielo claro
    800: {
      "d":'assets/weather/clear.png',
      "n": "assets/weather/clear_night.png"
    },
    // Algunas nubes
    801: {
      "d": 'assets/weather/few_clouds.png',
      "n": 'assets/weather/few_clouds_night.png'
    },
    802: {
      "d": 'assets/weather/scattered_clouds.png',
      "n": 'assets/weather/scattered_clouds_night.png'
    },

    // Nublado
    803: {
      "d": 'assets/weather/broken_clouds.png',
      "n": 'assets/weather/broken_clouds_night.png'
    },
    804: {
      "d": 'assets/weather/cloudy.png',
      "n": 'assets/weather/cloudy_night.png'
    },

    // Lluvias
    500: 'assets/weather/light_rain.png',
    501: 'assets/weather/moderate_rain.png',
    502: 'assets/weather/heavy_rain.png',
    520: 'assets/weather/shower_rain.png',

    // Tormenta
    200: 'assets/weather/thunderstorm.png',

    // Nieve
    600: 'assets/weather/snow.png',

    // Niebla
    701: 'assets/weather/mist.png',
  };

  if (dia == true && id! <= 804 ){
   return weatherIcons[id]?["d"] ?? 'assets/weather/default.png'; 

  } else {
    return weatherIcons[id]?["n"] ?? 'assets/weather/default.png';
  }

}