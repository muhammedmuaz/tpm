import 'baseConfig.dart';

class Enviroment {
  factory Enviroment() {
    return _singleton;
  }

  Enviroment.internal();
  static final Enviroment _singleton = Enviroment.internal();

  static const String dev = 'dev';
  static const String production = 'production';

  late BaseConfig config;

  initConfig(String enviroment) {
    config = _getConfig(enviroment);
  }

  BaseConfig _getConfig(String enviroment) {
    switch (enviroment) {
      case Enviroment.production:
        return ProductionConfig();
      default:
        return DevConfig();
    }
  }
}
