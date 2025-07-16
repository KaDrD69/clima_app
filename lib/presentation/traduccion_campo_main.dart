class TraduccionMain {

  static final Map<String, String> _traducciones = {
    'Clear': 'Despejado',
    'Clouds': 'Nublado',
    'Rain': 'Lluvia',
    'Drizzle': 'Llovizna',
    'Thunderstorm': 'Tormenta',
    'Snow': 'Nieve',
    'Mist': 'Niebla ligera',
    'Smoke': 'Humo',
    'Haze': 'Neblina',
    'Dust': 'Polvo',
    'Fog': 'Niebla',
    'Sand': 'Arena',
    'Ash': 'Ceniza volcánica',
    'Squall': 'Ráfaga',
    'Tornado': 'Tornado',
  };

  static String traducirMain(String mainIngles) {
    return _traducciones[mainIngles] ?? mainIngles;
  }
}
