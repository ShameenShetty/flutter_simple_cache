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

  static bool contains(String key) => _cache.containsKey(key);

  static void set(String key, dynamic value) => _cache[key] = value;

  static dynamic get(String key) => _cache[key];

  /// Returns the cached value for [key] if present,
  /// otherwise calls [fetcher], caches the result, and returns it.
  ///
  /// Designed for lazy evaluation of expensive operations
  /// (API calls, DB queries, etc.) to avoid repeated work.
  ///
  /// Pass [fetcher] as a function:
  /// ```dart
  /// getOrFetch('cities', () => getMysqlData()); // correct
  /// getOrFetch('cities', getMysqlData());       // wrong (still calls getMysqlData() immediately)
  /// ```
  static dynamic getOrFetch(String key, Function() fetcher) {
    if (contains(key)) {
      return get(key);
    } else {
      final value = fetcher();
      set(key, value);
      return value;
    }
  }

  static void remove(String key) => _cache.remove(key);
  static void invalidate(String key) => _cache.remove(key);
  static void clear() => _cache.clear();

  /// Returns the number of items in the cache.
  static int get size => _cache.length;
}
