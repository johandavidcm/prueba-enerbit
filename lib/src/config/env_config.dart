/// Esta clase es usada en caso de tener multiples ambientes poder configurar de cierto modo
/// variables de entorno y a su vez poder enviar despliegues a tiendas y demás de una manera más
/// sencilla

class EnvConfig {
  final Env flavor;
  final EnvValues values;

  static EnvConfig? _instance;

  factory EnvConfig({
    required Env flavor,
    required EnvValues values,
  }) =>
      _instance ??= EnvConfig._internalConstructor(flavor, values);

  EnvConfig._internalConstructor(this.flavor, this.values);

  static EnvConfig? get instance => _instance;

  static bool isProduction() => _instance?.flavor == Env.prod;

  static bool isDevelopment() => _instance?.flavor == Env.dev;
}

class EnvValues {
  EnvValues({
    required this.baseUrl,
    required this.charactersPath,
    required this.locationsPath,
    required this.episodesPath,
  });

  final String baseUrl;
  final String charactersPath;
  final String locationsPath;
  final String episodesPath;
}

enum Env {
  dev,
  prod,
}
