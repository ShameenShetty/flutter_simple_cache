class FlutterSimpleCache {
  static FlutterSimpleCache? _instance;
  static final Map<String, dynamic> _cache = {};
  FlutterSimpleCache._internal();

  static void init() {
    _instance ??= FlutterSimpleCache._internal();

    // TODO add config options
  }

  static FlutterSimpleCache get instance {
    if (_instance == null) {
      throw Exception("FlutterSimpleCache not initialized, call init()");
    }

    return _instance!;
  }

  static void set(String key, dynamic value) =>
      contains(key) ? null : _cache[key] = value;
  static dynamic get(String key) => _cache[key];

  static bool contains(String key) => _cache.containsKey(key);

  static void remove(String key) => _cache.remove(key);
  static void invalidate(String key) => _cache.remove(key);
  static void clear() => _cache.clear();

  /// Returns the number of items in the cache.
  static int get size => _cache.length;
}
