String obtenerIcono(String? dia, int? id){
  if (id == null) {
    return '';
  }

  Map<int, dynamic> weatherIcons = {
    // Cielo claro
    800: {
      "d":'assets/alter/clear.png',
      "n": "assets/alter/clear_night.png"
    },
    // Algunas nubes
    801: {
      "d": 'assets/alter/few_clouds.png',
      "n": 'assets/alter/few_clouds_night.png'
    },
    802: {
      "d": 'assets/alter/few_clouds.png',
      "n": 'assets/alter/few_clouds_night.png'
    },
    // Nublado
    803: {
      "d": 'assets/alter/few_clouds.png',
      "n": 'assets/alter/few_clouds_night.png'
    },
    // Nubes dispersas
    804: {
      "d": 'assets/alter/few_clouds.png',
      "n": 'assets/alter/few_clouds_night.png'
    },

    // Lluvias
    500: 'assets/alter/light_rain.png',
    501: 'assets/alter/light_rain.png',
    502: 'assets/alter/heavy_rain.png',
    520: 'assets/alter/heavy_rain.png',

    // Tormenta
    200: 'assets/alter/thunderstorm.png',

    // Nieve
    600: 'assets/alter/snow.png',

    // Niebla
    701: 'assets/alter/mist.png',
  };

  if (dia == true && id! >= 800 ){
   return weatherIcons[id]?["d"] ?? ''; 

  } else if (dia == false && id! >= 800) {
    return weatherIcons[id]?["n"] ?? '';
  }

  return weatherIcons[id] ?? '';
}