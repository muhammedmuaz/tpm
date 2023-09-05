abstract class BaseConfig {
  String get apiUrl;
  String get baseUrl;
  String get apiUrlClone;
}

class DevConfig implements BaseConfig {
  @override
  String get apiUrl => "http://192.168.24.5:8002/";
  @override
  String get baseUrl => "http://192.168.24.5:8002/";
  @override
  String get apiUrlClone => "";
}

class ProductionConfig implements BaseConfig {
  @override
  String get apiUrl => "";
  @override
  String get baseUrl => "";
  @override
  String get apiUrlClone => "";
}
