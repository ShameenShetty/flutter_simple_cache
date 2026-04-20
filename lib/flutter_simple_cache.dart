class FlutterSimpleCache {
  FlutterSimpleCache._internal();

  static final FlutterSimpleCache _instance = FlutterSimpleCache._internal();

  static FlutterSimpleCache get instance => _instance;
}
