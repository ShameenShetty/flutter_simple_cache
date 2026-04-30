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

  static void set<T>(String key, T value) => _cache[key] = value;

  static T? get<T>(String key) => _cache[key] as T?;

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
  static Future<T> getOrFetch<T>(
    String key,
    Future<T> Function() fetcher,
  ) async {
    if (contains(key)) {
      return get<T>(key)!;
    }

    final value = await fetcher();
    set<T>(key, value);
    return value;
  }

  static void remove(String key) => _cache.remove(key);
  static void invalidate(String key) => _cache.remove(key);
  static void clear() => _cache.clear();
  static void invalidateAll() => _cache.clear();

  /// Returns the number of items in the cache.
  static int get size => _cache.length;
  static void debugPrintStats() {
    print('--- FlutterSimpleCache ---');
    print('Total keys: ${_cache.length}');

    _cache.forEach((key, value) {
      if (value is Iterable) {
        print('$key -> ${value.length} items');
      } else if (value is Map) {
        print('$key -> ${value.length} entries');
      } else {
        print('$key -> ${value.runtimeType}');
      }
    });

    print('--------------------------');
  }
}
